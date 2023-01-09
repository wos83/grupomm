unit uPositionHistory;

interface

uses
  FireDAC.Comp.Client,

  System.Classes,
  System.JSON,
  System.SysUtils,
  System.Generics.Collections,

  RESTRequest4D,

  uLog,
  uConsts,
  uLibrary;

type
  TPosition = class
  private
    { Private declarations }
  public
    Id: integer;
    &Type: string;
    EquipmentId: integer;
    EquipmentModelId: integer;
    EquipmentModelName: string;
    EquipmentBrandId: integer;
    EquipmentBrandName: string;
    TerminalId: string;
    FirmwareVersion: string;
    VehicleId: integer;
    Plate: string;
    VehicleTypeId: integer;
    VehicleTypeName: string;
    VehicleSubTypeId: integer;
    VehicleSubTypeName: string;
    VehicleBrandId: integer;
    VehicleBrandName: string;
    VehicleModelId: integer;
    VehicleModelName: string;
    VehicleColorId: integer;
    VehicleColor: string;
    CustomerId: integer;
    SubsidiaryId: integer;
    CustomerName: string;
    EventDate: string;
    SystemDate: string;
    Latitude: string;
    Longitude: string;
    Address: string;
    MadeRequest: string;
    Satellites: integer;
    Course: integer;
    IgnitionStatus: boolean;
    Speed: integer;
    Odometer: integer;
    Horimeter: integer;
    PowerVoltage: string;
    Charge: boolean;
    BatteryVoltage: string;
    GsmSignalStrength: integer;
    Inputs: string;
    Outputs: string;
    Alarms: string;
    { Public declarations }
  end;

  TPositionHistory = class
  private
    { Private declarations }
  public
    Position: TPosition;
    Data: TObjectList<TPosition>;
    Page: integer;
    ItemsPerPage: integer;
    NumberOfPages: integer;
    NextPage: string;

    constructor Create;
    destructor Destroy; override;

    function CreateTablePositionHistory: boolean;

    function doPositionHistoryHours(AToken: string; AEquipmentId, AHours, APage: integer): boolean;
    function isExists: boolean;
    procedure saveData;
    { Public declarations }
  end;

var
  PositionHistory: TPositionHistory;

const
  SQL_CREATE_TABLE_POSITION_HISTORY = //
     'CREATE TABLE IF NOT EXISTS POSITIONS_HISTORY (' + sLineBreak + //
     'ID INTEGER PRIMARY KEY AUTOINCREMENT' + sLineBreak + //
     ',ID_USER INTEGER' + sLineBreak + //

     ',ID_POSITION_HISTORY INTEGER -- : 1930,' + sLineBreak + //
     ',DS_TYPE VARCHAR(255) -- : TRACKING,' + sLineBreak + //
     ',EQUIPMENT_ID INTEGER -- : 3250,' + sLineBreak + //
     ',EQUIPMENT_MODEL_ID INTEGER -- : 60,' + sLineBreak + //
     ',EQUIPMENT_MODEL_NAME VARCHAR(255) -- : NT20,' + sLineBreak + //
     ',EQUIPMENT_BRAND_ID INTEGER -- : 26,' + sLineBreak + //
     ',EQUIPMENT_BRAND_NAME VARCHAR(255) -- : X3TECH,' + sLineBreak + //
     ',TERMINAL_ID VARCHAR(255) -- : 0359510081341955,' + sLineBreak + //
     ',FIRMWARE_VERSION VARCHAR(255) -- : NULL,' + sLineBreak + //
     ',VEHICLE_ID INTEGER -- : NULL,' + sLineBreak + //
     ',PLATE VARCHAR(255) -- : NULL,' + sLineBreak + //
     ',VEHICLE_TYPE_ID INTEGER -- : NULL,' + sLineBreak + //
     ',VEHICLE_TYPE_NAME VARCHAR(255) -- : NULL,' + sLineBreak + //
     ',VEHICLE_SUB_TYPE_ID INTEGER -- : 0,' + sLineBreak + //
     ',VEHICLE_SUB_TYPE_NAME VARCHAR(255) -- : NÃO INFORMADO,' + sLineBreak + //
     ',VEHICLE_BRAND_ID INTEGER -- : NULL,' + sLineBreak + //
     ',VEHICLE_BRAND_NAME VARCHAR(255) -- : NULL,' + sLineBreak + //
     ',VEHICLE_MODEL_ID INTEGER -- : NULL,' + sLineBreak + //
     ',VEHICLE_MODEL_NAME VARCHAR(255) -- : NULL,' + sLineBreak + //
     ',VEHICLE_COLOR_ID INTEGER -- : NULL,' + sLineBreak + //
     ',VEHICLE_COLOR VARCHAR(255) -- : NULL,' + sLineBreak + //
     ',CUSTOMER_ID INTEGER -- : NULL,' + sLineBreak + //
     ',CUSTOMER_NAME VARCHAR(255) -- : NULL,' + sLineBreak + //
     ',SUBSIDIARY_ID INTEGER -- : NULL,' + sLineBreak + //
     ',EVENT_DATE DATETIME -- : 2022-11-12T20:49:26.000000Z,' + sLineBreak + //
     ',SYSTEM_DATE DATETIME -- : 2022-11-12T20:49:50.000000Z,' + sLineBreak + //
     ',LATITUDE REAL -- : -23.733922,' + sLineBreak + //
     ',LONGITUDE REAL -- : -47.325266,' + sLineBreak + //
     ',SATELLITES INTEGER -- : 11,' + sLineBreak + //
     ',COURSE INTEGER -- : 260,' + sLineBreak + //
     ',ADDRESS VARCHAR(512) -- : NULL' + sLineBreak + //
     ',IGNITION_STATUS BOOLEAN -- : TRUE,' + sLineBreak + //
     ',SPEED INTEGER -- : 30,' + sLineBreak + //
     ',ODOMETER INTEGER -- : 410,' + sLineBreak + //
     ',HORIMETER INTEGER -- : 1418,' + sLineBreak + //
     ',POWER_VOLTAGE REAL -- : 13.5,' + sLineBreak + //
     ',CHARGE BOOLEAN -- : TRUE,' + sLineBreak + //
     ',BATTERY_VOLTAGE REAL -- : 4,' + sLineBreak + //
     ',GSM_SIGNAL_STRENGTH INTEGER -- : 38,' + sLineBreak + //
     ',INPUTS TEXT -- : [],' + sLineBreak + //
     ',OUTPUTS TEXT -- : [],' + sLineBreak + //
     ',ALARMS VARCHAR(255) -- : NONE,' + sLineBreak + //

     ',FL_REG_STATUS INTEGER DEFAULT 1' + sLineBreak + //
     ',DT_REG_INS DATETIME DEFAULT CURRENT_TIMESTAMP' + sLineBreak + //
     ',DT_REG_UPD DATETIME' + sLineBreak + //
     ',DT_REG_DEL DATETIME' + sLineBreak + //
     ')' + sLineBreak + //
     '';

implementation

uses
  uDM,
  uUser;

constructor TPositionHistory.Create;
begin
  Position := TPosition.Create;
  Data := TObjectList<TPosition>.Create;
end;

destructor TPositionHistory.Destroy;
begin
  {$IFDEF MSWINDOWS}
  FreeAndNil(Data);
  FreeAndNil(Position);
  {$ENDIF}
  {$IFDEF ANDROID}
  Data.DisposeOf;
  Position.DisposeOf;
  {$ENDIF}
end;

function TPositionHistory.CreateTablePositionHistory: boolean;
var
  LQry: TFDQuery;
  LSQL: string;
begin
  Result := False;
  LSQL := SQL_CREATE_TABLE_POSITION_HISTORY;

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TPositionHistory.CreateTablePositionHistory', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TPositionHistory.CreateTablePositionHistory' + sLineBreak + LSQL);
  {$ENDIF}
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DM.FDConn;
    try
      LQry.ExecSQL(LSQL);
      Result := True;
    except
      on E: Exception do
      begin
        Logg.LogAppSQL( //
           'TPositionHistory.CreateTablePositionHistory' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TPositionHistory.CreateTablePositionHistory' + sLineBreak + //
           E.ClassName + '. ' + E.Message + sLineBreak + //
           LSQL);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LQry);
    {$ELSE}
    LQry.DisposeOf;
    {$ENDIF}
  end;
end;

function TPositionHistory.doPositionHistoryHours(AToken: string; AEquipmentId, AHours, APage: integer): boolean;
var
  LResponse: IResponse;

  LJsonObject: TJSONObject;
  LJsonValue: TJSONValue;
  LJsonObjectData: TJSONObject;
  LJsonValueData: TJSONValue;

  LCount: integer;
  LError: string;
begin
  Result := False;

  try
    LResponse := //
       TRequest.New.BaseURL(cAPI + Format(cAPI_PositionHistoryHours, [AEquipmentId, AHours, APage])) // '/position/history/%d/hours/%d?page=%d';
       .Accept(cAppJson) //
       .TokenBearer(AToken) //
       .Get;
  except
    on E: Exception do
    begin
      Logg.LogApp( //
         'TPositionHistory.doPositionHistoryHours' //
         , E.ClassName + '. ' + E.Message);

      Logg.LogDebug( //
         'TPositionHistory.doPositionHistoryHours' + sLineBreak + //
         E.ClassName + '. ' + E.Message + sLineBreak + //
         '');

      Exit;
    end;
  end;

  case LResponse.StatusCode of
    200:
      begin
        {$IFDEF DEBUG}
        Logg.LogAppREST( //
           'DEBUG: TPositionHistory.doPositionHistoryHours' //
           , EmptyStr //
           , EmptyStr //
           , 'GET' //
           , cAPI + cAPI_PositionHistoryPeriod //
           , LResponse.Headers.Text //
           , EmptyStr //
           , LResponse.JSONValue.ToString);

        Logg.LogDebug( //
           'DEBUG: TPositionHistory.doPositionHistoryHours' + sLineBreak + //
           'GET' + sLineBreak + //
           cAPI + cAPI_PositionHistoryPeriod + sLineBreak + //
           LResponse.Headers.Text + sLineBreak + //
           LResponse.JSONValue.ToString + sLineBreak + //
           '');
        {$ENDIF}
        {$REGION 'Preenche as Informações da Última Posição'}
        LJsonObject := TJSONObject.ParseJSONValue(LResponse.JSONValue.ToString) as TJSONObject;

        Page := StrToIntDef(LJsonObject.FindValue('page').Value, 0);
        ItemsPerPage := StrToIntDef(LJsonObject.FindValue('itemsPerPage').Value, 0);
        NumberOfPages := StrToIntDef(LJsonObject.FindValue('numberOfPages').Value, 0);

        LJsonValue := LJsonObject.GetValue('data');
        LJsonObjectData := TJSONObject.ParseJSONValue(LJsonValue.ToString) as TJSONObject;

        if not(LJsonObjectData = nil) then
        begin
          for LCount := 0 to Pred(LJsonObjectData.Count) do
          begin
            Logg.LogApp('DEBUG: TPositionHistory.doPositionHistoryHours - Lendo o registro ' + LCount.ToString + ' de ' + Pred(LJsonObjectData.Count).ToString, EmptyStr);
            Logg.LogDebug('DEBUG: TPositionHistory.doPositionHistoryHours - Lendo o registro ' + LCount.ToString + ' de ' + Pred(LJsonObjectData.Count).ToString + sLineBreak + EmptyStr);

            LJsonValueData := LJsonObjectData.GetValue(LCount.ToString);

            PositionHistory.Position.Id := StrToIntDef(LJsonValueData.FindValue('id').Value, 0);
            PositionHistory.Position.&Type := LJsonValueData.FindValue('type').Value;
            PositionHistory.Position.EquipmentId := StrToIntDef(LJsonValueData.FindValue('equipmentid').Value, 0);
            PositionHistory.Position.EquipmentModelId := StrToIntDef(LJsonValueData.FindValue('equipmentmodelid').Value, 0);
            PositionHistory.Position.EquipmentModelName := LJsonValueData.FindValue('equipmentmodelname').Value;
            PositionHistory.Position.EquipmentBrandId := StrToIntDef(LJsonValueData.FindValue('equipmentbrandid').Value, 0);
            PositionHistory.Position.EquipmentBrandName := LJsonValueData.FindValue('equipmentbrandname').Value;
            PositionHistory.Position.TerminalId := LJsonValueData.FindValue('terminalid').Value;
            PositionHistory.Position.FirmwareVersion := LJsonValueData.FindValue('firmwareversion').Value;
            PositionHistory.Position.VehicleId := StrToIntDef(LJsonValueData.FindValue('vehicleid').Value, 0);

            PositionHistory.Position.Plate := LJsonValueData.FindValue('plate').Value;
            if (PositionHistory.Position.Plate = 'null') or //
               (PositionHistory.Position.Plate = EmptyStr) or //
               (Length(PositionHistory.Position.Plate) = 0) then
              PositionHistory.Position.Plate := 'Novo';

            PositionHistory.Position.VehicleTypeId := StrToIntDef(LJsonValueData.FindValue('vehicletypeid').Value, 0);
            PositionHistory.Position.VehicleTypeName := LJsonValueData.FindValue('vehicletypename').Value;
            PositionHistory.Position.VehicleSubTypeId := StrToIntDef(LJsonValueData.FindValue('vehiclesubtypeid').Value, 0);
            PositionHistory.Position.VehicleSubTypeName := LJsonValueData.FindValue('vehiclesubtypename').Value;
            PositionHistory.Position.VehicleBrandId := StrToIntDef(LJsonValueData.FindValue('vehiclebrandid').Value, 0);
            PositionHistory.Position.VehicleBrandName := LJsonValueData.FindValue('vehiclebrandname').Value;
            PositionHistory.Position.VehicleModelId := StrToIntDef(LJsonValueData.FindValue('vehiclemodelid').Value, 0);
            PositionHistory.Position.VehicleModelName := LJsonValueData.FindValue('vehiclemodelname').Value;
            PositionHistory.Position.VehicleColorId := StrToIntDef(LJsonValueData.FindValue('vehiclecolorid').Value, 0);
            PositionHistory.Position.VehicleColor := LJsonValueData.FindValue('vehiclecolor').Value;
            PositionHistory.Position.CustomerId := StrToIntDef(LJsonValueData.FindValue('customerid').Value, 0);
            PositionHistory.Position.SubsidiaryId := StrToIntDef(LJsonValueData.FindValue('subsidiaryid').Value, 0);
            PositionHistory.Position.CustomerName := LJsonValueData.FindValue('customername').Value;
            PositionHistory.Position.EventDate := LJsonValueData.FindValue('eventdate').Value;
            PositionHistory.Position.SystemDate := LJsonValueData.FindValue('systemdate').Value;
            PositionHistory.Position.Latitude := LJsonValueData.FindValue('latitude').Value;
            PositionHistory.Position.Longitude := LJsonValueData.FindValue('longitude').Value;
            PositionHistory.Position.Address := LJsonValueData.FindValue('address').Value;
            PositionHistory.Position.MadeRequest := LJsonValueData.FindValue('maderequest').Value;
            PositionHistory.Position.Satellites := StrToIntDef(LJsonValueData.FindValue('satellites').Value, 0);
            PositionHistory.Position.Course := StrToIntDef(LJsonValueData.FindValue('course').Value, 0);
            PositionHistory.Position.IgnitionStatus := strtobooldef(LJsonValueData.FindValue('ignitionstatus').Value, False);
            PositionHistory.Position.Speed := StrToIntDef(LJsonValueData.FindValue('speed').Value, 0);
            PositionHistory.Position.Odometer := StrToIntDef(LJsonValueData.FindValue('odometer').Value, 0);
            PositionHistory.Position.Horimeter := StrToIntDef(LJsonValueData.FindValue('horimeter').Value, 0);
            PositionHistory.Position.PowerVoltage := LJsonValueData.FindValue('powervoltage').Value;
            PositionHistory.Position.Charge := strtobooldef(LJsonValueData.FindValue('charge').Value, False);
            PositionHistory.Position.BatteryVoltage := LJsonValueData.FindValue('batteryvoltage').Value;
            PositionHistory.Position.GsmSignalStrength := StrToIntDef(LJsonValueData.FindValue('gsmsignalstrength').Value, 0);
            PositionHistory.Position.Inputs := LJsonValueData.FindValue('inputs').Value;
            PositionHistory.Position.Outputs := LJsonValueData.FindValue('outputs').Value;
            PositionHistory.Position.Alarms := LJsonValueData.FindValue('alarms').Value;

            TThread.Queue(nil,
              procedure
              begin
                saveData;
              end);
          end;
        end;
        {$ENDREGION}
        Result := True;
      end;
  else
    begin
      LError := //
         'Erro ' + LResponse.StatusCode.ToString + ': ' + LResponse.StatusText + sLineBreak + //
         'Título: ' + LResponse.JSONValue.FindValue('title').Value + sLineBreak + //
         'Detalhe: ' + LResponse.JSONValue.FindValue('detail').Value + sLineBreak + //
         'Endpoint: ' + LResponse.JSONValue.FindValue('instance').Value;

      Logg.LogApp( //
         'TPositionHistory.doPositionHistoryHours' //
         , LError);

      Logg.LogDebug( //
         'TPositionHistory.doPositionHistoryHours' + sLineBreak + //
         LError + sLineBreak + //
         '');
    end;
  end;
end;

function TPositionHistory.isExists: boolean;
var
  LQry: TFDQuery;
  LSQL: string;
begin
  Result := False;

  LSQL := //
     'SELECT COUNT(1) AS QTD' + sLineBreak + //
     'FROM POSITIONS_HISTORY' + sLineBreak + //
     'WHERE 1 = 1' + sLineBreak + //
     'AND ID_POSITION_HISTORY = ' + PositionHistory.Position.Id.ToString + sLineBreak + //
     '';

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TPositionHistory.isExists', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TPositionHistory.isExists' + sLineBreak + LSQL);
  {$ENDIF}
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DM.FDConn;
    try
      LQry.Open(LSQL);
      Result := not(LQry.Fields[0].AsInteger = 0);
    except
      on E: Exception do
      begin
        Logg.LogAppSQL( //
           'TPositionHistory.isExists' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TPositionHistory.isExists' + sLineBreak + //
           E.ClassName + '. ' + E.Message + sLineBreak + //
           LSQL);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LQry);
    {$ELSE}
    LQry.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TPositionHistory.saveData;
var
  LQry: TFDQuery;
  LSQL: string;
  LMessage: string;
begin
  if (PositionHistory.Position.Id = 0) then
  begin
    LMessage := 'APP: TPositionHistory.saveData - Última Posição não conseguiu identificar o ID';
    Logg.LogApp(LMessage, EmptyStr);
    Logg.LogDebug(LMessage);
    Exit;
  end;

  if not isExists then
  begin
    LSQL := //
       'INSERT INTO POSITIONS_HISTORY (' + sLineBreak + //

       'ID_USER' + sLineBreak + //
       ',ID_POSITION_HISTORY' + sLineBreak + //
       ',DS_TYPE' + sLineBreak + //
       ',EQUIPMENT_ID' + sLineBreak + //
       ',EQUIPMENT_MODEL_ID' + sLineBreak + //
       ',EQUIPMENT_MODEL_NAME' + sLineBreak + //
       ',EQUIPMENT_BRAND_ID' + sLineBreak + //
       ',EQUIPMENT_BRAND_NAME' + sLineBreak + //
       ',TERMINAL_ID' + sLineBreak + //
       ',FIRMWARE_VERSION' + sLineBreak + //
       ',VEHICLE_ID' + sLineBreak + //
       ',PLATE' + sLineBreak + //
       ',VEHICLE_TYPE_ID' + sLineBreak + //
       ',VEHICLE_TYPE_NAME' + sLineBreak + //
       ',VEHICLE_SUB_TYPE_ID' + sLineBreak + //
       ',VEHICLE_SUB_TYPE_NAME' + sLineBreak + //
       ',VEHICLE_BRAND_ID' + sLineBreak + //
       ',VEHICLE_BRAND_NAME' + sLineBreak + //
       ',VEHICLE_MODEL_ID' + sLineBreak + //
       ',VEHICLE_MODEL_NAME' + sLineBreak + //
       ',VEHICLE_COLOR_ID' + sLineBreak + //
       ',VEHICLE_COLOR' + sLineBreak + //
       ',CUSTOMER_ID' + sLineBreak + //
       ',CUSTOMER_NAME' + sLineBreak + //
       ',SUBSIDIARY_ID' + sLineBreak + //
       ',EVENT_DATE' + sLineBreak + //
       ',SYSTEM_DATE' + sLineBreak + //
       ',LATITUDE' + sLineBreak + //
       ',LONGITUDE' + sLineBreak + //
       ',SATELLITES' + sLineBreak + //
       ',COURSE' + sLineBreak + //
       ',ADDRESS' + sLineBreak + //
       ',IGNITION_STATUS' + sLineBreak + //
       ',SPEED' + sLineBreak + //
       ',ODOMETER' + sLineBreak + //
       ',HORIMETER' + sLineBreak + //
       ',POWER_VOLTAGE' + sLineBreak + //
       ',CHARGE' + sLineBreak + //
       ',BATTERY_VOLTAGE' + sLineBreak + //
       ',GSM_SIGNAL_STRENGTH' + sLineBreak + //
       ',INPUTS' + sLineBreak + //
       ',OUTPUTS' + sLineBreak + //
       ',ALARMS' + sLineBreak + //

       ')VALUES(' + sLineBreak + //

       IntToStr(User.Id) + ' -- ID_USER' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.Id) + ' -- ,ID_POSITION_HISTORY' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.&Type) + ' -- ,DS_TYPE' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.EquipmentId) + ' -- ,EQUIPMENT_ID' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.EquipmentModelId) + ' -- ,EQUIPMENT_MODEL_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.EquipmentModelName) + ' -- ,EQUIPMENT_MODEL_NAME' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.EquipmentBrandId) + ' -- ,EQUIPMENT_BRAND_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.EquipmentBrandName) + ' -- ,EQUIPMENT_BRAND_NAME' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.TerminalId) + ' -- ,TERMINAL_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.FirmwareVersion) + ' -- ,FIRMWARE_VERSION' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.VehicleId) + ' -- ,VEHICLE_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.Plate) + ' -- ,PLATE' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.VehicleTypeId) + ' -- ,VEHICLE_TYPE_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.VehicleTypeName) + ' -- ,VEHICLE_TYPE_NAME' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.VehicleSubTypeId) + ' -- ,VEHICLE_SUB_TYPE_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.VehicleSubTypeName) + ' -- ,VEHICLE_SUB_TYPE_NAME' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.VehicleBrandId) + ' -- ,VEHICLE_BRAND_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.VehicleBrandName) + ' -- ,VEHICLE_BRAND_NAME' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.VehicleModelId) + ' -- ,VEHICLE_MODEL_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.VehicleModelName) + ' -- ,VEHICLE_MODEL_NAME' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.VehicleColorId) + ' -- ,VEHICLE_COLOR_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.VehicleColor) + ' -- ,VEHICLE_COLOR' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.CustomerId) + ' -- ,CUSTOMER_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.CustomerName) + ' -- ,CUSTOMER_NAME' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.SubsidiaryId) + ' -- ,SUBSIDIARY_ID' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.EventDate) + ' -- ,EVENT_DATE' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.SystemDate) + ' -- ,SYSTEM_DATE' + sLineBreak + //
       ',' + Trim(PositionHistory.Position.Latitude) + ' -- ,LATITUDE' + sLineBreak + //
       ',' + Trim(PositionHistory.Position.Longitude) + ' -- ,LONGITUDE' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.Satellites) + ' -- ,SATELLITES' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.Course) + ' -- ,COURSE' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.Address) + ' -- ,ADDRESS' + sLineBreak + //
       ',' + LowerCase(PositionHistory.Position.IgnitionStatus.ToString) + ' -- ,IGNITION_STATUS' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.Speed) + ' -- ,SPEED' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.Odometer) + ' -- ,ODOMETER' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.Horimeter) + ' -- ,HORIMETER' + sLineBreak + //
       ',' + Trim(PositionHistory.Position.PowerVoltage) + ' -- ,POWER_VOLTAGE' + sLineBreak + //
       ',' + LowerCase(PositionHistory.Position.Charge.ToString) + ' -- ,CHARGE' + sLineBreak + //
       ',' + PositionHistory.Position.BatteryVoltage + ' -- ,BATTERY_VOLTAGE' + sLineBreak + //
       ',' + IntToStr(PositionHistory.Position.GsmSignalStrength) + ' -- ,GSM_SIGNAL_STRENGTH' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.Inputs) + ' -- ,INPUTS' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.Outputs) + ' -- ,OUTPUTS' + sLineBreak + //
       ',' + QuotedStr(PositionHistory.Position.Alarms) + ' -- ,ALARMS' + sLineBreak + //

       ')';
  end
  else
  begin
    LSQL := //
       'UPDATE POSITIONS_HISTORY SET' + sLineBreak + //

       'ID_USER = ' + IntToStr(User.Id) + sLineBreak + //
       ',ID_POSITION_HISTORY = ' + IntToStr(PositionHistory.Position.Id) + sLineBreak + //
       ',DS_TYPE = ' + QuotedStr(PositionHistory.Position.&Type) + sLineBreak + //
       ',EQUIPMENT_ID = ' + IntToStr(PositionHistory.Position.EquipmentId) + sLineBreak + //
       ',EQUIPMENT_MODEL_ID = ' + IntToStr(PositionHistory.Position.EquipmentModelId) + sLineBreak + //
       ',EQUIPMENT_MODEL_NAME = ' + QuotedStr(PositionHistory.Position.EquipmentModelName) + sLineBreak + //
       ',EQUIPMENT_BRAND_ID = ' + IntToStr(PositionHistory.Position.EquipmentBrandId) + sLineBreak + //
       ',EQUIPMENT_BRAND_NAME = ' + QuotedStr(PositionHistory.Position.EquipmentBrandName) + sLineBreak + //
       ',TERMINAL_ID = ' + QuotedStr(PositionHistory.Position.TerminalId) + sLineBreak + //
       ',FIRMWARE_VERSION = ' + QuotedStr(PositionHistory.Position.FirmwareVersion) + sLineBreak + //
       ',VEHICLE_ID = ' + IntToStr(PositionHistory.Position.VehicleId) + sLineBreak + //
       ',PLATE = ' + QuotedStr(PositionHistory.Position.Plate) + sLineBreak + //
       ',VEHICLE_TYPE_ID = ' + IntToStr(PositionHistory.Position.VehicleTypeId) + sLineBreak + //
       ',VEHICLE_TYPE_NAME = ' + QuotedStr(PositionHistory.Position.VehicleTypeName) + sLineBreak + //
       ',VEHICLE_SUB_TYPE_ID = ' + IntToStr(PositionHistory.Position.VehicleSubTypeId) + sLineBreak + //
       ',VEHICLE_SUB_TYPE_NAME = ' + QuotedStr(PositionHistory.Position.VehicleSubTypeName) + sLineBreak + //
       ',VEHICLE_BRAND_ID = ' + IntToStr(PositionHistory.Position.VehicleBrandId) + sLineBreak + //
       ',VEHICLE_BRAND_NAME = ' + QuotedStr(PositionHistory.Position.VehicleBrandName) + sLineBreak + //
       ',VEHICLE_MODEL_ID = ' + IntToStr(PositionHistory.Position.VehicleModelId) + sLineBreak + //
       ',VEHICLE_MODEL_NAME = ' + QuotedStr(PositionHistory.Position.VehicleModelName) + sLineBreak + //
       ',VEHICLE_COLOR_ID = ' + IntToStr(PositionHistory.Position.VehicleColorId) + sLineBreak + //
       ',VEHICLE_COLOR = ' + QuotedStr(PositionHistory.Position.VehicleColor) + sLineBreak + //
       ',CUSTOMER_ID = ' + IntToStr(PositionHistory.Position.CustomerId) + sLineBreak + //
       ',CUSTOMER_NAME = ' + QuotedStr(PositionHistory.Position.CustomerName) + sLineBreak + //
       ',SUBSIDIARY_ID = ' + IntToStr(PositionHistory.Position.SubsidiaryId) + sLineBreak + //
       ',EVENT_DATE = ' + QuotedStr(PositionHistory.Position.EventDate) + sLineBreak + //
       ',SYSTEM_DATE = ' + QuotedStr(PositionHistory.Position.SystemDate) + sLineBreak + //
       ',LATITUDE = ' + Trim(PositionHistory.Position.Latitude) + sLineBreak + //
       ',LONGITUDE = ' + Trim(PositionHistory.Position.Longitude) + sLineBreak + //
       ',SATELLITES = ' + IntToStr(PositionHistory.Position.Satellites) + sLineBreak + //
       ',COURSE = ' + IntToStr(PositionHistory.Position.Course) + sLineBreak + //
       ',ADDRESS = ' + QuotedStr(PositionHistory.Position.Address) + sLineBreak + //
       ',IGNITION_STATUS = ' + LowerCase(PositionHistory.Position.IgnitionStatus.ToString) + sLineBreak + //
       ',SPEED = ' + IntToStr(PositionHistory.Position.Speed) + sLineBreak + //
       ',ODOMETER = ' + IntToStr(PositionHistory.Position.Odometer) + sLineBreak + //
       ',HORIMETER = ' + IntToStr(PositionHistory.Position.Horimeter) + sLineBreak + //
       ',POWER_VOLTAGE = ' + Trim(PositionHistory.Position.PowerVoltage) + sLineBreak + //
       ',CHARGE = ' + LowerCase(PositionHistory.Position.Charge.ToString) + sLineBreak + //
       ',BATTERY_VOLTAGE = ' + PositionHistory.Position.BatteryVoltage + sLineBreak + //
       ',GSM_SIGNAL_STRENGTH = ' + IntToStr(PositionHistory.Position.GsmSignalStrength) + sLineBreak + //
       ',INPUTS = ' + QuotedStr(PositionHistory.Position.Inputs) + sLineBreak + //
       ',OUTPUTS = ' + QuotedStr(PositionHistory.Position.Outputs) + sLineBreak + //
       ',ALARMS = ' + QuotedStr(PositionHistory.Position.Alarms) + sLineBreak + //

       'WHERE 1 = 1' + sLineBreak + //
       'AND ID_POSITION_HISTORY = ' + IntToStr(PositionHistory.Position.Id) + sLineBreak + //

       '';
  end;

  LSQL := StringReplace(LSQL, QuotedStr('null'), 'null', [rfReplaceAll]);

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TPositionHistory.saveData', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TPositionHistory.saveData' + sLineBreak + LSQL);
  {$ENDIF}
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := DM.FDConn;
    try
      LQry.ExecSQL(LSQL);
    except
      on E: Exception do
      begin
        Logg.LogAppSQL( //
           'TPositionHistory.saveData' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TPositionHistory.saveData' + sLineBreak + //
           E.ClassName + '. ' + E.Message + sLineBreak + //
           LSQL);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LQry);
    {$ELSE}
    LQry.DisposeOf;
    {$ENDIF}
  end;
end;

end.
