-- =====================================================================
-- Posições
-- =====================================================================
-- O armazenamento do histórico de posições dos rastreadores.
-- =====================================================================

-- ---------------------------------------------------------------------
-- O registro de posições (histórico)
-- ---------------------------------------------------------------------
-- A tabela (particionada) que armazena os registros de posições de cada
-- equipamento ao longo do tempo.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS positions CASCADE;
CREATE TABLE IF NOT EXISTS positions (
  positionID              serial,       -- ID da posição
  device_id               varchar       -- Número de série do dispositivo
                          NOT NULL,     -- de rastreamento
  equipmentID             integer,      -- ID do equipamento
  fw_version              varchar,      -- Versão do firmware
  eventDate               timestamp     -- A data/hora do evento
                          NOT NULL,
  plate                   varchar(7),   -- A placa do veículo
  vehicleID               integer,      -- O ID do veículo se vinculado
  customerID              integer,      -- O ID do cliente se vinculado
  subsidiaryID            integer,      -- O ID da unidade/filial do cliente
  systemDate              timestamp     -- A data/hora do registro no
                          NOT NULL      -- sistema
                          DEFAULT CURRENT_TIMESTAMP,
  latitude                varchar       -- A latitude da posição
                          NOT NULL,
  longitude               varchar       -- A longitude da posição
                          NOT NULL,
  speed                   integer,
  course                  integer,
  satellite               integer,
  odometer                varchar,
  main_battery            varchar,
  backup_battery          varchar,
  ignition                boolean,
  input_one               boolean,
  input_two               boolean,
  input_three             boolean,
  output_one              boolean,
  output_two              boolean,
  gps_fix                 boolean,
  backup_battery_percent  varchar,
  address                 varchar,      -- O endereço relativo à posição geográfica
  driverID                integer,      -- ID do motorista
  rs232Data               varchar,      -- Os dados da porta serial
  PRIMARY KEY (positionID)
);

-- ---------------------------------------------------------------------
-- O registro da última posição de cada equipamento
-- ---------------------------------------------------------------------
-- A tabela que armazena o registro da última posição de cada
-- equipamento ao longo.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS last_positions CASCADE;
CREATE TABLE IF NOT EXISTS last_positions (
  positionID              integer,      -- ID da posição
  device_id               varchar       -- Número de série do dispositivo
                          NOT NULL,     -- de rastreamento
  equipmentID             integer,      -- ID do equipamento
  fw_version              varchar,      -- Versão do firmware
  eventDate               timestamp     -- A data/hora do evento
                          NOT NULL,
  plate                   varchar(7),   -- A placa do veículo
  vehicleID               integer,      -- O ID do veículo se vinculado
  customerID              integer,      -- O ID do cliente se vinculado
  subsidiaryID            integer,      -- O ID da unidade/filial do cliente
  systemDate              timestamp     -- A data/hora do registro no
                          NOT NULL      -- sistema
                          DEFAULT CURRENT_TIMESTAMP,
  latitude                varchar       -- A latitude da posição
                          NOT NULL,
  longitude               varchar       -- A longitude da posição
                          NOT NULL,
  speed                   integer,
  course                  integer,
  satellite               integer,
  odometer                varchar,
  main_battery            varchar,
  backup_battery          varchar,
  ignition                boolean,
  input_one               boolean,
  input_two               boolean,
  input_three             boolean,
  output_one              boolean,
  output_two              boolean,
  gps_fix                 boolean,
  backup_battery_percent  varchar,
  PRIMARY KEY (positionID)
);

-- ---------------------------------------------------------------------
-- Gatilho para processar inserções na tabela de posições
-- ---------------------------------------------------------------------
-- Cria um gatilho que lida com as inserções de registros na tabela de
-- posições, criando as partições se necessário, identificando o
-- equipamento e o veículo, se possível, e atualizando as últimas
-- posições de cada equipamento de rastreamento.
-- ---------------------------------------------------------------------
DROP FUNCTION IF EXISTS positionTransaction();
CREATE OR REPLACE FUNCTION positionTransaction()
RETURNS trigger AS
$BODY$
  DECLARE
    yearOfPositionDate  char(4);
    monthOfPositionDate  char(2);
    startOfMonth date;
    endOfMonth date;
    partition  varchar;
    newPositionID  integer;
  BEGIN
    -- Faz a criação de uma nova partição, se necessário, nos processos
    -- em que se insere os dados de posicionamento obtidos. Faz uso da
    -- variável especial TG_OP para verificar a operação executada.
    IF (TG_OP = 'INSERT') THEN
      IF (TG_WHEN = 'BEFORE') THEN
        BEGIN
          yearOfPositionDate := extract(YEAR FROM NEW.eventDate);
          monthOfPositionDate := LPAD(extract(MONTH FROM NEW.eventDate)::varchar, 2, '0');
          partition := TG_RELNAME || '_' || yearOfPositionDate || monthOfPositionDate;
          startOfMonth := to_char(NEW.eventDate, 'YYYY-MM-01');
          endOfMonth := date_trunc('MONTH', NEW.eventDate) + INTERVAL '1 MONTH - 1 day';
          
          -- Verifica se a tabela existe
          IF NOT EXISTS(SELECT T.relname, N.nspname FROM pg_catalog.pg_class AS T JOIN pg_catalog.pg_namespace AS N ON T.relnamespace = N.oid WHERE T.relname = partition AND N.nspname = 'public') THEN
            RAISE NOTICE 'A partição %/% da tabela de % está sendo criada', monthOfPositionDate, yearOfPositionDate, TG_RELNAME;
            EXECUTE 'CREATE TABLE ' || partition || ' ( CHECK ( eventDate >= DATE ''' || startOfMonth || '''  AND eventDate <=  DATE ''' ||  endOfMonth || ''' )) INHERITS (' || TG_RELNAME || ');';
            EXECUTE 'CREATE INDEX ' || partition || '_byevent ON '  || partition || '(eventDate)';
            EXECUTE 'CREATE INDEX ' || partition || '_byequipment ON '  || partition || '(equipmentID, eventDate)';
            EXECUTE 'ALTER TABLE ' || partition || ' ADD primary key(positionID);';
            EXECUTE 'ALTER TABLE ' || partition || ' ADD CONSTRAINT ' || partition || '_unique UNIQUE (device_id, eventDate, latitude, longitude);';
          END IF;

          -- Acrescenta a informação do ID do rastreador e do veículo
          -- associado, caso ela exista
          SELECT E.equipmentID,
                 V.plate,
                 V.vehicleID,
                 V.customerID,
                 V.subsidiaryID
            INTO NEW.equipmentID, NEW.plate, NEW.vehicleID, NEW.customerID, NEW.subsidiaryID
            FROM erp.equipments AS E
           INNER JOIN erp.equipmentModels AS M USING (equipmentModelID)
            LEFT JOIN erp.vehicles AS V USING (vehicleID)
           WHERE LPAD(E.serialNumber, M.serialNumberSize, '0') = NEW.device_id;
          -- IF FOUND THEN
          --   RAISE NOTICE 'Identificado equipamento ID %', NEW.equipmentID;
          --   IF NEW.vehicleID IS NOT NULL THEN
          --     RAISE NOTICE 'Identificado veículo ID % %', NEW.vehicleID, NEW.plate;
          --     RAISE NOTICE 'Cliente ID % %', NEW.customerID, NEW.subsidiaryID;
          --   END IF;
          -- ELSE
          IF NOT FOUND THEN
            RAISE WARNING 'Equipamento não cadastrado';
          END IF;

          EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING positionID;'
            INTO newPositionID;

          -- Atualiza o registro de última posição
          IF EXISTS (SELECT 1 FROM last_positions WHERE device_id = NEW.device_id ) THEN
            RAISE NOTICE 'UPDATE last position of Device: %', NEW.device_id;
            UPDATE last_positions
               SET positionID = newPositionID,
                   equipmentID = NEW.equipmentID,
                   fw_version = NEW.fw_version,
                   eventDate = NEW.eventDate,
                   plate = NEW.plate,
                   vehicleID = NEW.vehicleID,
                   customerID = NEW.customerID,
                   subsidiaryID = NEW.subsidiaryID,
                   systemDate = NEW.systemDate,
                   latitude = NEW.latitude,
                   longitude = NEW.longitude,
                   speed = NEW.speed,
                   course = NEW.course,
                   satellite = NEW.satellite,
                   odometer = NEW.odometer,
                   main_battery = NEW.main_battery,
                   backup_battery = NEW.backup_battery,
                   ignition = NEW.ignition,
                   input_one = NEW.input_one,
                   input_two = NEW.input_two,
                   input_three = NEW.input_three,
                   output_one = NEW.output_one,
                   output_two = NEW.output_two,
                   gps_fix = NEW.gps_fix,
                   backup_battery_percent = NEW.backup_battery_percent
             WHERE device_id = NEW.device_id;
          ELSE
            RAISE NOTICE 'INSERT last position of Device: %', NEW.device_id;
            INSERT INTO last_positions (positionID, device_id,
                    equipmentID, fw_version, eventDate, plate,
                    vehicleID, customerID, subsidiaryID, systemDate,
                    latitude, longitude, speed, course, satellite,
                    odometer, main_battery, backup_battery, ignition,
                    input_one, input_two, input_three, output_one,
                    output_two, gps_fix, backup_battery_percent)
            VALUES (newPositionID, NEW.device_id, NEW.equipmentID,
                    NEW.fw_version, NEW.eventDate, NEW.plate,
                    NEW.vehicleID, NEW.customerID, NEW.subsidiaryID,
                    NEW.systemDate, NEW.latitude, NEW.longitude,
                    NEW.speed, NEW.course, NEW.satellite, NEW.odometer,
                    NEW.main_battery, NEW.backup_battery, NEW.ignition,
                    NEW.input_one, NEW.input_two, NEW.input_three,
                    NEW.output_one, NEW.output_two, NEW.gps_fix,
                    NEW.backup_battery_percent);
          END IF;
          
          RETURN NULL;

          EXCEPTION WHEN unique_violation THEN  
            RAISE WARNING 'O valor de chave duplicado viola a restrição de exclusividade "%" em "%"', 
              TG_NAME, TG_TABLE_NAME 
              USING DETAIL = format('Chave (device_id)=(%s) (eventDate)=(%s) (latitude)=(%s) (longitude)=(%s) já existe.', NEW.device_id, NEW.eventDate, NEW.latitude, NEW.longitude);
            RETURN NULL;
        END;
      END IF;
    END IF;
  END;
$BODY$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS positionTransactionTrigger ON positions;
CREATE TRIGGER positionTransactionTrigger
  BEFORE INSERT ON positions
  FOR EACH ROW EXECUTE PROCEDURE positionTransaction();

-- INSERT INTO positions 
--        (device_id, fw_version, eventDate, systemDate, latitude,
--         longitude, speed, course, satellite, odometer, main_battery,
--         backup_battery, ignition, input_one, input_two, input_three,
--         output_one, output_two, gps_fix, backup_battery_percent)
-- VALUES ('0357789642345067', NULL, '2022-07-09 19:01:18',
--         '2022-07-09 16:01:31.249', '-23.32914', '-46.72522055555556',
--         0, 3800, 203, NULL, '050c', '27', false, false, false, false,
--         false, false, false, NULL);
