unit uPositionLast;

interface

uses
  FireDAC.Comp.Client,

  System.Classes,
  System.JSON,
  System.SysUtils,
  System.Generics.Collections,

  {$IFDEF MSWINDOWS}
  Vcl.ExtCtrls,
  {$ELSE}
  FMX.Types,
  {$ENDIF}
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

  TPositionLast = class
  private
    procedure doUpdatePositionLast(Sender: TObject);
    { Private declarations }
  public
    Timer: TTimer;
    Position: TPosition;
    Data: TObjectList<TPosition>;
    Page: integer;
    ItemsPerPage: integer;
    NumberOfPages: integer;

    constructor Create;
    destructor Destroy; override;

    function CreateTablePositionLast: boolean;

    function doPositionLast(AToken: string): boolean;
    function isExists: boolean;
    procedure saveData;
    { Public declarations }
  end;

var
  PositionLast: TPositionLast;

const
  SQL_CREATE_TABLE_POSITION_LAST = //
     'CREATE TABLE IF NOT EXISTS POSITIONS_LAST (' + sLineBreak + //
     'ID INTEGER PRIMARY KEY AUTOINCREMENT' + sLineBreak + //
     ',ID_USER INTEGER' + sLineBreak + //

     ',ID_POSITION_LAST INTEGER -- : 1930,' + sLineBreak + //
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
  uFrmMain,
  uUser;

constructor TPositionLast.Create;
begin
  Timer := TTimer.Create(nil);
  Timer.Enabled := False;
  Timer.Interval := 1000;
  Timer.OnTimer := doUpdatePositionLast;

  Position := TPosition.Create;
  Data := TObjectList<TPosition>.Create;
end;

destructor TPositionLast.Destroy;
begin
  {$IFDEF MSWINDOWS}
  FreeAndNil(Timer);
  FreeAndNil(Data);
  FreeAndNil(Position);
  {$ENDIF}
  {$IFDEF ANDROID}
  Timer.DisposeOf;
  Data.DisposeOf;
  Position.DisposeOf;
  {$ENDIF}
end;

function TPositionLast.CreateTablePositionLast: boolean;
var
  LQry: TFDQuery;
  LSQL: string;
begin
  Result := False;
  LSQL := SQL_CREATE_TABLE_POSITION_LAST;

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TPositionLast.CreateTablePositionLast', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TPositionLast.CreateTablePositionLast' + sLineBreak + LSQL);
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
           'TPositionLast.CreateTablePositionLast' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TPositionLast.CreateTablePositionLast' + sLineBreak + //
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

function TPositionLast.doPositionLast(AToken: string): boolean;
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
       TRequest.New.BaseURL(cAPI + cAPI_PositionLast) //
       .Accept(cAppJson) //
       .TokenBearer(AToken) //
       .Get;
  except
    on E: Exception do
    begin
      Logg.LogApp( //
         'TPositionLast.doPositionLast' //
         , E.ClassName + '. ' + E.Message);

      Logg.LogDebug( //
         'TPositionLast.doPositionLast' + sLineBreak + //
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
           'DEBUG: TPositionLast.doPositionLast' //
           , EmptyStr //
           , EmptyStr //
           , 'GET' //
           , cAPI + cAPI_PositionLast //
           , LResponse.Headers.Text //
           , EmptyStr //
           , LResponse.JSONValue.ToString);

        Logg.LogDebug( //
           'DEBUG: TPositionLast.doPositionLast' + sLineBreak + //
           'GET' + sLineBreak + //
           cAPI + cAPI_PositionLast + sLineBreak + //
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
            {$IFDEF DEBUG}
            Logg.LogApp('DEBUG: TPositionLast.doPositionLast - Lendo o registro ' + LCount.ToString + ' de ' + Pred(LJsonObjectData.Count).ToString, EmptyStr);
            Logg.LogDebug('DEBUG: TPositionLast.doPositionLast - Lendo o registro ' + LCount.ToString + ' de ' + Pred(LJsonObjectData.Count).ToString + sLineBreak + EmptyStr);
            {$ENDIF}
            LJsonValueData := LJsonObjectData.GetValue(LCount.ToString);

            {$REGION 'Preenche as Informações da Última Posição'}
            PositionLast.Position.Id := StrToIntDef(LJsonValueData.FindValue('id').Value, 0);
            PositionLast.Position.&Type := LJsonValueData.FindValue('type').Value;
            PositionLast.Position.EquipmentId := StrToIntDef(LJsonValueData.FindValue('equipmentid').Value, 0);
            PositionLast.Position.EquipmentModelId := StrToIntDef(LJsonValueData.FindValue('equipmentmodelid').Value, 0);
            PositionLast.Position.EquipmentModelName := LJsonValueData.FindValue('equipmentmodelname').Value;
            PositionLast.Position.EquipmentBrandId := StrToIntDef(LJsonValueData.FindValue('equipmentbrandid').Value, 0);
            PositionLast.Position.EquipmentBrandName := LJsonValueData.FindValue('equipmentbrandname').Value;
            PositionLast.Position.TerminalId := LJsonValueData.FindValue('terminalid').Value;
            PositionLast.Position.FirmwareVersion := LJsonValueData.FindValue('firmwareversion').Value;
            PositionLast.Position.VehicleId := StrToIntDef(LJsonValueData.FindValue('vehicleid').Value, 0);

            PositionLast.Position.Plate := LJsonValueData.FindValue('plate').Value;
            if (PositionLast.Position.Plate = 'null') or //
               (PositionLast.Position.Plate = EmptyStr) or //
               (Length(PositionLast.Position.Plate) = 0) then
              PositionLast.Position.Plate := 'Novo';

            PositionLast.Position.VehicleTypeId := StrToIntDef(LJsonValueData.FindValue('vehicletypeid').Value, 0);
            PositionLast.Position.VehicleTypeName := LJsonValueData.FindValue('vehicletypename').Value;
            PositionLast.Position.VehicleSubTypeId := StrToIntDef(LJsonValueData.FindValue('vehiclesubtypeid').Value, 0);
            PositionLast.Position.VehicleSubTypeName := LJsonValueData.FindValue('vehiclesubtypename').Value;
            PositionLast.Position.VehicleBrandId := StrToIntDef(LJsonValueData.FindValue('vehiclebrandid').Value, 0);
            PositionLast.Position.VehicleBrandName := LJsonValueData.FindValue('vehiclebrandname').Value;
            PositionLast.Position.VehicleModelId := StrToIntDef(LJsonValueData.FindValue('vehiclemodelid').Value, 0);
            PositionLast.Position.VehicleModelName := LJsonValueData.FindValue('vehiclemodelname').Value;
            PositionLast.Position.VehicleColorId := StrToIntDef(LJsonValueData.FindValue('vehiclecolorid').Value, 0);
            PositionLast.Position.VehicleColor := LJsonValueData.FindValue('vehiclecolor').Value;
            PositionLast.Position.CustomerId := StrToIntDef(LJsonValueData.FindValue('customerid').Value, 0);
            PositionLast.Position.SubsidiaryId := StrToIntDef(LJsonValueData.FindValue('subsidiaryid').Value, 0);
            PositionLast.Position.CustomerName := LJsonValueData.FindValue('customername').Value;
            PositionLast.Position.EventDate := LJsonValueData.FindValue('eventdate').Value;
            PositionLast.Position.SystemDate := LJsonValueData.FindValue('systemdate').Value;
            PositionLast.Position.Latitude := LJsonValueData.FindValue('latitude').Value;
            PositionLast.Position.Longitude := LJsonValueData.FindValue('longitude').Value;
            PositionLast.Position.Address := LJsonValueData.FindValue('address').Value;
            PositionLast.Position.MadeRequest := LJsonValueData.FindValue('maderequest').Value;
            PositionLast.Position.Satellites := StrToIntDef(LJsonValueData.FindValue('satellites').Value, 0);
            PositionLast.Position.Course := StrToIntDef(LJsonValueData.FindValue('course').Value, 0);
            PositionLast.Position.IgnitionStatus := strtobooldef(LJsonValueData.FindValue('ignitionstatus').Value, False);
            PositionLast.Position.Speed := StrToIntDef(LJsonValueData.FindValue('speed').Value, 0);
            PositionLast.Position.Odometer := StrToIntDef(LJsonValueData.FindValue('odometer').Value, 0);
            PositionLast.Position.Horimeter := StrToIntDef(LJsonValueData.FindValue('horimeter').Value, 0);
            PositionLast.Position.PowerVoltage := LJsonValueData.FindValue('powervoltage').Value;
            PositionLast.Position.Charge := strtobooldef(LJsonValueData.FindValue('charge').Value, False);
            PositionLast.Position.BatteryVoltage := LJsonValueData.FindValue('batteryvoltage').Value;
            PositionLast.Position.GsmSignalStrength := StrToIntDef(LJsonValueData.FindValue('gsmsignalstrength').Value, 0);
            PositionLast.Position.Inputs := LJsonValueData.FindValue('inputs').Value;
            PositionLast.Position.Outputs := LJsonValueData.FindValue('outputs').Value;
            PositionLast.Position.Alarms := LJsonValueData.FindValue('alarms').Value;
            {$ENDREGION}
            TThread.Queue(nil,
              procedure
              begin
                saveData;
              end);
          end;
          Result := True;
        end;
        {$ENDREGION}
      end;
  else
    begin
      LError := //
         'Erro ' + LResponse.StatusCode.ToString + ': ' + LResponse.StatusText + sLineBreak + //
         'Título: ' + LResponse.JSONValue.FindValue('title').Value + sLineBreak + //
         'Detalhe: ' + LResponse.JSONValue.FindValue('detail').Value + sLineBreak + //
         'Endpoint: ' + LResponse.JSONValue.FindValue('instance').Value;

      Logg.LogApp( //
         'TPositionLast.doPositionLast' //
         , LError);

      Logg.LogDebug( //
         'TPositionLast.doPositionLast' + sLineBreak + //
         LError + sLineBreak + //
         '');
    end;
  end;
end;

function TPositionLast.isExists: boolean;
var
  LQry: TFDQuery;
  LSQL: string;
begin
  Result := False;

  LSQL := //
     'SELECT COUNT(1) AS QTD' + sLineBreak + //
     'FROM POSITIONS_LAST' + sLineBreak + //
     'WHERE 1 = 1' + sLineBreak + //
     'AND TERMINAL_ID = ' + QuotedStr(PositionLast.Position.TerminalId) + sLineBreak + //
     '';

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TPositionLast.isExists', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TPositionLast.isExists' + sLineBreak + LSQL);
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
           'TPositionLast.isExists' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TPositionLast.isExists' + sLineBreak + //
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

procedure TPositionLast.saveData;
var
  LQry: TFDQuery;
  LSQL: string;
  LMessage: string;
begin
  if (PositionLast.Position.Id = 0) then
  begin
    LMessage := 'APP: TPositionLast.saveData - Última Posição não conseguiu identificar o ID';
    Logg.LogApp(LMessage, EmptyStr);
    Logg.LogDebug(LMessage);
    Exit;
  end;

  if not isExists then
  begin
    LSQL := //
       'INSERT INTO POSITIONS_LAST (' + sLineBreak + //

       'ID_USER' + sLineBreak + //
       ',ID_POSITION_LAST' + sLineBreak + //
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
       ',' + IntToStr(PositionLast.Position.Id) + ' -- ,ID_POSITION_LAST' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.&Type) + ' -- ,DS_TYPE' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.EquipmentId) + ' -- ,EQUIPMENT_ID' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.EquipmentModelId) + ' -- ,EQUIPMENT_MODEL_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.EquipmentModelName) + ' -- ,EQUIPMENT_MODEL_NAME' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.EquipmentBrandId) + ' -- ,EQUIPMENT_BRAND_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.EquipmentBrandName) + ' -- ,EQUIPMENT_BRAND_NAME' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.TerminalId) + ' -- ,TERMINAL_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.FirmwareVersion) + ' -- ,FIRMWARE_VERSION' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.VehicleId) + ' -- ,VEHICLE_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.Plate) + ' -- ,PLATE' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.VehicleTypeId) + ' -- ,VEHICLE_TYPE_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.VehicleTypeName) + ' -- ,VEHICLE_TYPE_NAME' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.VehicleSubTypeId) + ' -- ,VEHICLE_SUB_TYPE_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.VehicleSubTypeName) + ' -- ,VEHICLE_SUB_TYPE_NAME' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.VehicleBrandId) + ' -- ,VEHICLE_BRAND_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.VehicleBrandName) + ' -- ,VEHICLE_BRAND_NAME' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.VehicleModelId) + ' -- ,VEHICLE_MODEL_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.VehicleModelName) + ' -- ,VEHICLE_MODEL_NAME' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.VehicleColorId) + ' -- ,VEHICLE_COLOR_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.VehicleColor) + ' -- ,VEHICLE_COLOR' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.CustomerId) + ' -- ,CUSTOMER_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.CustomerName) + ' -- ,CUSTOMER_NAME' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.SubsidiaryId) + ' -- ,SUBSIDIARY_ID' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.EventDate) + ' -- ,EVENT_DATE' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.SystemDate) + ' -- ,SYSTEM_DATE' + sLineBreak + //
       ',' + Trim(PositionLast.Position.Latitude) + ' -- ,LATITUDE' + sLineBreak + //
       ',' + Trim(PositionLast.Position.Longitude) + ' -- ,LONGITUDE' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.Satellites) + ' -- ,SATELLITES' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.Course) + ' -- ,COURSE' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.Address) + ' -- ,ADDRESS' + sLineBreak + //
       ',' + LowerCase(PositionLast.Position.IgnitionStatus.ToString) + ' -- ,IGNITION_STATUS' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.Speed) + ' -- ,SPEED' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.Odometer) + ' -- ,ODOMETER' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.Horimeter) + ' -- ,HORIMETER' + sLineBreak + //
       ',' + Trim(PositionLast.Position.PowerVoltage) + ' -- ,POWER_VOLTAGE' + sLineBreak + //
       ',' + LowerCase(PositionLast.Position.Charge.ToString) + ' -- ,CHARGE' + sLineBreak + //
       ',' + PositionLast.Position.BatteryVoltage + ' -- ,BATTERY_VOLTAGE' + sLineBreak + //
       ',' + IntToStr(PositionLast.Position.GsmSignalStrength) + ' -- ,GSM_SIGNAL_STRENGTH' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.Inputs) + ' -- ,INPUTS' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.Outputs) + ' -- ,OUTPUTS' + sLineBreak + //
       ',' + QuotedStr(PositionLast.Position.Alarms) + ' -- ,ALARMS' + sLineBreak + //

       ')';
  end
  else
  begin
    LSQL := //
       'UPDATE POSITIONS_LAST SET' + sLineBreak + //

       'ID_USER = ' + IntToStr(User.Id) + sLineBreak + //
       ',ID_POSITION_LAST = ' + IntToStr(PositionLast.Position.Id) + sLineBreak + //
       ',DS_TYPE = ' + QuotedStr(PositionLast.Position.&Type) + sLineBreak + //
       ',EQUIPMENT_ID = ' + IntToStr(PositionLast.Position.EquipmentId) + sLineBreak + //
       ',EQUIPMENT_MODEL_ID = ' + IntToStr(PositionLast.Position.EquipmentModelId) + sLineBreak + //
       ',EQUIPMENT_MODEL_NAME = ' + QuotedStr(PositionLast.Position.EquipmentModelName) + sLineBreak + //
       ',EQUIPMENT_BRAND_ID = ' + IntToStr(PositionLast.Position.EquipmentBrandId) + sLineBreak + //
       ',EQUIPMENT_BRAND_NAME = ' + QuotedStr(PositionLast.Position.EquipmentBrandName) + sLineBreak + //
       ',TERMINAL_ID = ' + QuotedStr(PositionLast.Position.TerminalId) + sLineBreak + //
       ',FIRMWARE_VERSION = ' + QuotedStr(PositionLast.Position.FirmwareVersion) + sLineBreak + //
       ',VEHICLE_ID = ' + IntToStr(PositionLast.Position.VehicleId) + sLineBreak + //
       ',PLATE = ' + QuotedStr(PositionLast.Position.Plate) + sLineBreak + //
       ',VEHICLE_TYPE_ID = ' + IntToStr(PositionLast.Position.VehicleTypeId) + sLineBreak + //
       ',VEHICLE_TYPE_NAME = ' + QuotedStr(PositionLast.Position.VehicleTypeName) + sLineBreak + //
       ',VEHICLE_SUB_TYPE_ID = ' + IntToStr(PositionLast.Position.VehicleSubTypeId) + sLineBreak + //
       ',VEHICLE_SUB_TYPE_NAME = ' + QuotedStr(PositionLast.Position.VehicleSubTypeName) + sLineBreak + //
       ',VEHICLE_BRAND_ID = ' + IntToStr(PositionLast.Position.VehicleBrandId) + sLineBreak + //
       ',VEHICLE_BRAND_NAME = ' + QuotedStr(PositionLast.Position.VehicleBrandName) + sLineBreak + //
       ',VEHICLE_MODEL_ID = ' + IntToStr(PositionLast.Position.VehicleModelId) + sLineBreak + //
       ',VEHICLE_MODEL_NAME = ' + QuotedStr(PositionLast.Position.VehicleModelName) + sLineBreak + //
       ',VEHICLE_COLOR_ID = ' + IntToStr(PositionLast.Position.VehicleColorId) + sLineBreak + //
       ',VEHICLE_COLOR = ' + QuotedStr(PositionLast.Position.VehicleColor) + sLineBreak + //
       ',CUSTOMER_ID = ' + IntToStr(PositionLast.Position.CustomerId) + sLineBreak + //
       ',CUSTOMER_NAME = ' + QuotedStr(PositionLast.Position.CustomerName) + sLineBreak + //
       ',SUBSIDIARY_ID = ' + IntToStr(PositionLast.Position.SubsidiaryId) + sLineBreak + //
       ',EVENT_DATE = ' + QuotedStr(PositionLast.Position.EventDate) + sLineBreak + //
       ',SYSTEM_DATE = ' + QuotedStr(PositionLast.Position.SystemDate) + sLineBreak + //
       ',LATITUDE = ' + Trim(PositionLast.Position.Latitude) + sLineBreak + //
       ',LONGITUDE = ' + Trim(PositionLast.Position.Longitude) + sLineBreak + //
       ',SATELLITES = ' + IntToStr(PositionLast.Position.Satellites) + sLineBreak + //
       ',COURSE = ' + IntToStr(PositionLast.Position.Course) + sLineBreak + //
       ',ADDRESS = ' + QuotedStr(PositionLast.Position.Address) + sLineBreak + //
       ',IGNITION_STATUS = ' + LowerCase(PositionLast.Position.IgnitionStatus.ToString) + sLineBreak + //
       ',SPEED = ' + IntToStr(PositionLast.Position.Speed) + sLineBreak + //
       ',ODOMETER = ' + IntToStr(PositionLast.Position.Odometer) + sLineBreak + //
       ',HORIMETER = ' + IntToStr(PositionLast.Position.Horimeter) + sLineBreak + //
       ',POWER_VOLTAGE = ' + Trim(PositionLast.Position.PowerVoltage) + sLineBreak + //
       ',CHARGE = ' + LowerCase(PositionLast.Position.Charge.ToString) + sLineBreak + //
       ',BATTERY_VOLTAGE = ' + PositionLast.Position.BatteryVoltage + sLineBreak + //
       ',GSM_SIGNAL_STRENGTH = ' + IntToStr(PositionLast.Position.GsmSignalStrength) + sLineBreak + //
       ',INPUTS = ' + QuotedStr(PositionLast.Position.Inputs) + sLineBreak + //
       ',OUTPUTS = ' + QuotedStr(PositionLast.Position.Outputs) + sLineBreak + //
       ',ALARMS = ' + QuotedStr(PositionLast.Position.Alarms) + sLineBreak + //

       'WHERE 1 = 1' + sLineBreak + //
       'AND TERMINAL_ID = ' + QuotedStr(PositionLast.Position.TerminalId) + sLineBreak + //

       '';
  end;

  LSQL := StringReplace(LSQL, QuotedStr('null'), 'null', [rfReplaceAll]);

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TPositionLast.saveData', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TPositionLast.saveData' + sLineBreak + LSQL);
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
           'TPositionLast.saveData' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TPositionLast.saveData' + sLineBreak + //
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

procedure TPositionLast.doUpdatePositionLast(Sender: TObject);
begin
  TThread.Queue(nil,
    procedure
    begin
      Timer.Enabled := False;
      try
        TThread.Synchronize(nil,
          procedure
          begin
          {$REGION 'Synchronize'}
            {$IFDEF DEBUG}
            Logg.LogApp('DEBUG: TPositionLast.doUpdatePositionLast - Atualizou o registro ', EmptyStr);
            Logg.LogDebug('DEBUG: TPositionLast.doUpdatePositionLast - Atualizou o registro ' + sLineBreak + EmptyStr);
            {$ENDIF}
            doPositionLast(User.TokenCredential);
          {$ENDREGION}
          end);
      finally
        Timer.Interval := 60000;
        Timer.Enabled := True;
      end;
    end);
end;

end.
