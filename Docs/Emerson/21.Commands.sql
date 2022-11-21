-- =====================================================================
-- Comandos
-- =====================================================================
-- O armazenamento de comandos transmitidos aos equipamentos
-- =====================================================================

-- ---------------------------------------------------------------------
-- O registro de comandos enviados
-- ---------------------------------------------------------------------
-- A tabela (particionada) que armazena os registros de comandos sendo
-- enviados ao longo do tempo. Após o envio, o comando é retirado desta
-- tabela e mantido em histórico.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS send_commands (
  id            serial,       -- ID do comando
  command_name  varchar       -- O comando solicitado
                NOT NULL,
  data          varchar       -- Os dados de parâmetro do comando
                NOT NULL,
  device_id     varchar       -- Número de série do dispositivo de
                NOT NULL,     -- rastreamento
  manufacturer  varchar       -- O fabricante do equipamento
                NOT NULL
                DEFAULT 'ST',
  request_date  timestamp     -- A data/hora da requisição do comando
                NOT NULL
                DEFAULT CURRENT_TIMESTAMP,
  sent_date     timestamp,    -- A data/hora do envio do comando
  PRIMARY KEY (id)
);

-- ---------------------------------------------------------------------
-- O registro de histórico de comandos
-- ---------------------------------------------------------------------
-- A tabela (particionada) que armazena os registros de comandos
-- enviados aos equipamentos de rastreamento ao longo do tempo.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS history_commands (
  historyID     serial,       -- ID do histórico de comando
  command_name  varchar       -- O comando solicitado
                NOT NULL,
  data          varchar       -- Os dados de parâmetro do comando
                NOT NULL,
  device_id     varchar       -- Número de série do dispositivo de
                NOT NULL,     -- rastreamento
  manufacturer  varchar       -- O fabricante do equipamento
                NOT NULL
                DEFAULT 'ST',
  equipmentID   integer,      -- ID do equipamento
  plate         varchar(7),   -- A placa do veículo se vinculado
  vehicleID     integer,      -- O ID do veículo se vinculado
  customerID    integer,      -- O ID do cliente se vinculado
  subsidiaryID  integer,      -- O ID da unidade/filial do cliente
  request_date  timestamp     -- A data/hora da requisição
                NOT NULL
                DEFAULT CURRENT_TIMESTAMP,
  sent_date     timestamp,    -- A data/hora do envio
  confirm_date  timestamp,    -- A data/hora da confirmação
  PRIMARY KEY (historyID)
);

-- Gatilho para processar inserções na tabela de histórico de comandos
CREATE OR REPLACE FUNCTION historyCommandTransaction()
RETURNS trigger AS
$BODY$
  DECLARE
    yearOfHistoryDate  char(4);
    monthOfHistoryDate  char(2);
    startOfMonth date;
    endOfMonth date;
    partition  varchar;
  BEGIN
    -- Faz a criação de uma nova partição, se necessário, nos processos
    -- em que se insere os dados de comandos enviados. Faz uso da
    -- variável especial TG_OP para verificar a operação executada.
    IF (TG_OP = 'INSERT') THEN
    BEGIN
      yearOfHistoryDate := extract(YEAR FROM NEW.request_date);
      monthOfHistoryDate := LPAD(extract(MONTH FROM NEW.request_date)::varchar, 2, '0');
      partition := TG_RELNAME || '_' || yearOfHistoryDate || monthOfHistoryDate;
      startOfMonth := to_char(NEW.request_date, 'YYYY-MM-01');
      endOfMonth := date_trunc('MONTH', NEW.request_date) + INTERVAL '1 MONTH - 1 day';
      
      -- Verifica se a tabela existe
      IF NOT EXISTS(SELECT T.relname, N.nspname FROM pg_catalog.pg_class AS T JOIN pg_catalog.pg_namespace AS N ON T.relnamespace = N.oid WHERE T.relname = partition AND N.nspname = 'public') THEN
        RAISE NOTICE 'A partição %/% da tabela de % está sendo criada', monthOfHistoryDate, yearOfHistoryDate, TG_RELNAME;
        EXECUTE 'CREATE TABLE ' || partition || ' ( CHECK ( request_date >= DATE ''' || startOfMonth || '''  AND request_date <=  DATE ''' ||  endOfMonth || ''' )) INHERITS (' || TG_RELNAME || ');';
        EXECUTE 'CREATE INDEX ' || partition || '_byequipment ON '  || partition || '(equipmentID, request_date)';
        EXECUTE 'ALTER TABLE ' || partition || ' ADD primary key(historyID);';
        EXECUTE 'ALTER TABLE ' || partition || ' ADD CONSTRAINT ' || partition || '_unique UNIQUE (device_id, request_date, command_name);';
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

      EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING historyID;';
      
      RETURN NULL;

      EXCEPTION WHEN unique_violation THEN  
        RAISE WARNING 'O valor de chave duplicado viola a restrição de exclusividade "%" em "%"', 
          TG_NAME, TG_TABLE_NAME 
          USING DETAIL = format('Chave (device_id)=(%s) (request_date)=(%s) (command_name)=(%s) já existe.', NEW.device_id, NEW.request_date, NEW.command_name);
        RETURN NULL;
      END;
    END IF;
  END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER historyCommandTransactionTrigger
  BEFORE INSERT ON history_commands
  FOR EACH ROW EXECUTE PROCEDURE historyCommandTransaction();
