unit uDM;

interface

uses
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteCli,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLiteMeta,
  FireDAC.Phys.SQLiteWrapper,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  //
  FMX.DialogService,
  FMX.Forms,
  //
  REST.Client,
  REST.Response.Adapter,
  REST.Types,
  //
  System.Classes,
  System.DateUtils,
  System.IOUtils,
  System.JSON,
  System.StrUtils,
  System.SysUtils,
  //
  uConsts,
  uLibrary;

type
  TUser = record
    Id: integer;
    Username: string;
    Password: string;

    Name: string;
    Role: string;
    Mobile: string;
    Email: string;

    CreatedAt: string;
    UpdatedAt: string;
    LastLogin: string;

    GroupId: integer;
    GroupName: string;

    EntityId: integer;
    EntityName: string;

    EntityTypeId: integer;
    EntityTypeName: string;

    Cooperative: boolean;
    JuridicalPerson: boolean;

    TokenType: string;
    TokenCredential: string;
    TokenEmission: string;
    TokenLifetime: integer;
  end;

  TDM = class(TDataModule)
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDConn: TFDConnection;
    FDQry: TFDQuery;
    restDataPL: TRESTResponseDataSetAdapter;
    tblPL: TFDMemTable;
    restRespPL: TRESTResponse;
    restPL: TRESTClient;
    restReqPL: TRESTRequest;

    procedure FDConnBeforeConnect(Sender: TObject);

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure insereDadosLogin;
    procedure insereDadosUltimaPosicao(AJsonData: string);
    { Private declarations }
  public
    FLogin: TFDMemTable;
    FPositionLast: TFDMemTable;

    function doCreateDB: boolean;

    function doLogin(AUsername, APassword, AUUID: string): boolean;
    function doPositionLast(AToken: string): boolean;
    { Public declarations }
  end;

var
  DM: TDM;
  FUser: TUser;

const
  cNameConnDef = 'GMMTrakerSQLite';

  cAPI = 'http://vps35067.publiccloud.com.br/api';
  cAppJson = 'application/json';
  cBearerToken = 'Bearer %s';

  cUUID = '827d8338-6d0c-bf85-3ea2-ff1f66fd70d3';

  cAPI_Login = '/login';
  cAPI_PositionLast = '/position/last';

  cMSG_CAMPO_VAZIO = 'O campo não pode ficar em branco!';
  cMSG_SUPORTE = 'Entre em contato com o suporte.';

implementation

{$R *.dfm}

function TDM.doLogin(AUsername, APassword, AUUID: string): boolean;
var
  LError: string;
  LRESTClient: TRESTClient;
  LRESTRequest: TRESTRequest;
  LRESTResponse: TRESTResponse;
  LRESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
  LParam: TRESTRequestParameter;

const
  cBody = '{"username":"%s","password":"%s","uuid":"%s"}';

begin
  LError := EmptyStr;

  LRESTClient := TRESTClient.Create(nil);
  LRESTRequest := TRESTRequest.Create(nil);
  LRESTResponse := TRESTResponse.Create(nil);
  LRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  try
    LRESTRequest.Client := LRESTClient;
    LRESTRequest.Response := LRESTResponse;

    Result := False;

    LRESTClient.ResetToDefaults;
    LRESTRequest.ResetToDefaults;
    LRESTResponse.ResetToDefaults;
    LRESTResponseDataSetAdapter.ResetToDefaults;

    LRESTClient.BaseURL := cAPI + cAPI_Login;
    LRESTClient.ContentType := cAppJson;

    LRESTRequest.Method := TRESTRequestMethod.rmPOST;

    LRESTRequest.Params.Clear;

    LParam := LRESTRequest.Params.AddItem;
    LParam.Name := 'body' + GenerateRandomStringOnlyLetter(16);
    LParam.Kind := TRESTRequestParameterKind.pkREQUESTBODY;
    LParam.Value := Format(cBody, [AUsername, APassword, cUUID]);
    LParam.ContentTypeStr := TRESTContentType.ctAPPLICATION_JSON;
    LParam.Options := [TRESTRequestParameterOption.poDoNotEncode];

    LRESTResponseDataSetAdapter.DataSet := FLogin;
    LRESTResponseDataSetAdapter.Response := LRESTResponse;
    LRESTResponseDataSetAdapter.NestedElements := True;

    try
      LRESTRequest.Execute;
    except
      on E: Exception do
      begin
        LError := //
           E.ClassName + '. ' + E.Message  + sLineBreak + //
        // LRESTClient.BaseURL + sLineBreak + //
        // LRESTClient.Params[0].Name + sLineBreak + //
        // LRESTClient.Params[0].Value + sLineBreak + //
           '';

        // LogApp( //
        // 'TDM.doLogin' //
        // , LError //
        // , EmptyStr);
      end;
    end;
    {$IFDEF DEBUG}
    // LogApp( //
    // 'DEBUG: TDM.doLogin' //
    // , EmptyStr //
    // , EmptyStr //
    // , 'POST' //
    // , LRESTClient.BaseURL //
    // , LParam.Name + ' | ' + LParam.Value //
    // , LRESTRequest.GetFullRequestBody //
    // , LRESTResponse.Content);
    {$ENDIF}
    if FLogin.Active then
    begin
      if not FLogin.IsEmpty then
      begin
        FUser.Id := FLogin.FindField('id').AsInteger;
        FUser.Username := FLogin.FindField('username').AsString;
        FUser.Password := APassword;
        FUser.Name := FLogin.FindField('name').AsString;
        FUser.Mobile := FLogin.FindField('phonenumber').AsString;
        FUser.Email := FLogin.FindField('email').AsString;
        FUser.Role := FLogin.FindField('role').AsString;

        FUser.CreatedAt := FLogin.FindField('createdat').AsString;
        FUser.UpdatedAt := FLogin.FindField('updatedat').AsString;
        FUser.LastLogin := FLogin.FindField('lastlogin').AsString;

        FUser.GroupId := FLogin.FindField('groupid').AsInteger;
        FUser.GroupName := FLogin.FindField('groupname').AsString;

        FUser.EntityId := FLogin.FindField('entity.id').AsInteger;
        FUser.EntityName := FLogin.FindField('entity.name').AsString;

        FUser.EntityTypeId := FLogin.FindField('entity.entitytypeid').AsInteger;
        FUser.EntityTypeName := FLogin.FindField('entity.entitytypename').AsString;

        FUser.Cooperative := FLogin.FindField('entity.cooperative').AsBoolean;
        FUser.JuridicalPerson := FLogin.FindField('entity.juridicalperson').AsBoolean;

        FUser.TokenType := FLogin.FindField('token.type').AsString;
        FUser.TokenCredential := LRESTResponse.JSONValue.FindValue('token.credential').Value;
        FUser.TokenEmission := FLogin.FindField('token.emission').AsString;
        FUser.TokenLifetime := FLogin.FindField('token.lifetime').AsInteger;

        TThread.Queue(nil,
          procedure
          begin
            insereDadosLogin;
          end);

        Result := True;
      end;
    end;

  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LRESTClient);
    FreeAndNil(LRESTRequest);
    FreeAndNil(LRESTResponse);
    FreeAndNil(LRESTResponseDataSetAdapter);
    {$ENDIF}
    {$IFDEF ANDROID}
    LRESTClient.DisposeOf;
    LRESTRequest.DisposeOf;
    LRESTResponse.DisposeOf;
    LRESTResponseDataSetAdapter.DisposeOf;
    {$ENDIF}
  end;
end;

function TDM.doPositionLast(AToken: string): boolean;
var
  FQry: TFDQuery;
  LSQL: string;

  LError: string;

  LRESTClient: TRESTClient;
  LRESTRequest: TRESTRequest;
  LRESTResponse: TRESTResponse;
  LRESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
  LParam: TRESTRequestParameter;

  LJsonObjectData: TJSONObject;
  LJsonValueData: TJSONValue;

  LJsonObjectDatas: TJSONObject;
  LJsonValueDatas: TJSONValue;

  LJsonResult: string;
  LJsonData: string;
  LTotal: integer;
  LCount: integer;

const
  cID = '"id":';

begin
  LError := EmptyStr;
  Result := False;

  LRESTClient := TRESTClient.Create(nil);
  LRESTRequest := TRESTRequest.Create(nil);
  LRESTResponse := TRESTResponse.Create(nil);
  LRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  try
    LRESTRequest.Client := LRESTClient;
    LRESTRequest.Response := LRESTResponse;

    LRESTClient.ResetToDefaults;
    LRESTRequest.ResetToDefaults;
    LRESTResponse.ResetToDefaults;
    LRESTResponseDataSetAdapter.ResetToDefaults;

    LRESTClient.BaseURL := cAPI + cAPI_PositionLast;
    LRESTClient.ContentType := cAppJson;

    LRESTRequest.Method := TRESTRequestMethod.rmGET;

    LRESTRequest.Params.Clear;

    LParam := LRESTRequest.Params.AddItem;
    LParam.Name := 'Authorization';
    LParam.Kind := TRESTRequestParameterKind.pkHTTPHEADER;
    LParam.Value := Format(cBearerToken, [AToken]);
    LParam.Options := [TRESTRequestParameterOption.poDoNotEncode];

    LRESTResponseDataSetAdapter.DataSet := FPositionLast;
    LRESTResponseDataSetAdapter.Response := LRESTResponse;
    LRESTResponseDataSetAdapter.NestedElements := True;

    try
      LRESTRequest.Execute;
    except
      on E: Exception do
      begin
        LError := //
           E.ClassName + '. ' + E.Message + sLineBreak + //
        // LRESTClient.BaseURL + sLineBreak + //
        // LRESTClient.Params[0].Name + sLineBreak + //
        // LRESTClient.Params[0].Value + sLineBreak + //
        '';

        // LogApp( //
        // 'TDM.doPositionLast' //
        // , LError //
        // , EmptyStr);
      end;
    end;
    {$IFDEF DEBUG}
    // LogApp( //
    // 'DEBUG: TDM.doPositionLast' //
    // , EmptyStr //
    // , EmptyStr //
    // , 'GET' //
    // , LRESTClient.BaseURL //
    // , LParam.Name + ' | ' + LParam.Value //
    // , LRESTRequest.GetFullRequestBody //
    // , LRESTResponse.Content);
    {$ENDIF}
    if FPositionLast.Active then
    begin
      if not FPositionLast.IsEmpty then
      begin
        LJsonResult := LRESTResponse.Content;
        LTotal := CountWords(cID, LJsonResult);

        // Limpar a Tabela
        LSQL := //
           'DELETE' + sLineBreak + //
           'FROM POSITIONS_LAST' + sLineBreak + //
           '';

        {$IFDEF DEBUG}
        // LogApp('DEBUG', EmptyStr, LSQL);
        {$ENDIF}
        FQry := TFDQuery.Create(nil);
        try
          FQry.Connection := FDConn;

          try
            FQry.ExecSQL(LSQL);
          except
            on E: Exception do
            begin
              LogApp( //
                 'TDM.doPositionLast' //
                 , E.ClassName + '. ' + E.Message //
                 , LSQL);
            end;
          end;
        finally
          {$IFDEF MSWINDOWS}
          FreeAndNil(FQry);
          {$ENDIF}
          {$IFDEF ANDROID}
          FQry.DisposeOf;
          {$ENDIF}
        end;

        for LCount := 0 to Pred(LTotal) do
        begin
          Application.ProcessMessages;

          LJsonObjectData := TJSONObject.ParseJSONValue(LJsonResult) as TJSONObject;
          LJsonValueData := LJsonObjectData.GetValue('data');

          if not(LJsonValueData = nil) then
          begin
            LJsonObjectDatas := TJSONObject.ParseJSONValue(LJsonValueData.ToJSON) as TJSONObject;
            LJsonValueDatas := LJsonObjectDatas.GetValue(LCount.ToString);

            if not(LJsonValueDatas = nil) then
            begin
              LJsonData := LJsonValueDatas.ToJSON;

              TThread.Queue(nil,
                procedure
                begin
                  insereDadosUltimaPosicao(LJsonData);
                end);
            end;
          end;
        end;
        Toast('Últimas Posições Atualizadas!', 3);
        Result := True;
      end;
    end;

  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LRESTClient);
    FreeAndNil(LRESTRequest);
    FreeAndNil(LRESTResponse);
    FreeAndNil(LRESTResponseDataSetAdapter);
    {$ENDIF}
    {$IFDEF ANDROID}
    LRESTClient.DisposeOf;
    LRESTRequest.DisposeOf;
    LRESTResponse.DisposeOf;
    LRESTResponseDataSetAdapter.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FLogin := TFDMemTable.Create(nil);
  FPositionLast := TFDMemTable.Create(nil);
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  FreeAndNil(FLogin);
  FreeAndNil(FPositionLast);
  {$ENDIF}
  {$IFDEF ANDROID}
  FLogin.DisposeOf;
  FPositionLast.DisposeOf;
  {$ENDIF}
end;

procedure TDM.insereDadosLogin;
var
  FQry: TFDQuery;
  LSQL: string;
begin
  LSQL := //
     'INSERT INTO USERS (' + sLineBreak + //

     'ID_USER' + sLineBreak + //
     ',DS_NAME' + sLineBreak + //
     ',DS_ROLE' + sLineBreak + //
     ',ID_GROUP' + sLineBreak + //
     ',DS_GROUP' + sLineBreak + //
     ',DS_LOGIN' + sLineBreak + //
     ',DS_PASSWORD' + sLineBreak + //
     ',DS_PHONE' + sLineBreak + //
     ',DS_EMAIL' + sLineBreak + //

     ',DT_CREATEAT' + sLineBreak + //
     ',DT_UPDATEAT' + sLineBreak + //
     ',DT_LASTLOGIN' + sLineBreak + //

     ',ID_ENTITY' + sLineBreak + //
     ',DS_ENTITY' + sLineBreak + //
     ',ID_ENTITY_TYPE' + sLineBreak + //
     ',DS_ENTITY_TYPE' + sLineBreak + //

     ',DS_TOKEN_TYPE' + sLineBreak + //
     ',DS_TOKEN' + sLineBreak + //
     ',DT_TOKEN' + sLineBreak + //
     ',NR_TOKEN_LIFETIME' + sLineBreak + //
     ',DT_TOKEN_EXPIRE' + sLineBreak + //

     ')VALUES(' + sLineBreak + //

     IntToStr(FUser.Id) + ' --ID_USER' + sLineBreak + //
     ',' + QuotedStr(FUser.Name) + ' --,DS_NAME' + sLineBreak + //
     ',' + QuotedStr(FUser.Role) + ' --,DS_ROLE' + sLineBreak + //
     ',' + IntToStr(FUser.GroupId) + ' --,ID_GROUP' + sLineBreak + //
     ',' + QuotedStr(FUser.GroupName) + ' --,DS_GROUP' + sLineBreak + //
     ',' + QuotedStr(FUser.Username) + ' --,DS_LOGIN' + sLineBreak + //
     ',' + QuotedStr(FUser.Password) + ' --,DS_PASSWORD' + sLineBreak + //
     ',' + QuotedStr(FUser.Mobile) + ' --,DS_PHONE' + sLineBreak + //
     ',' + QuotedStr(FUser.Email) + ' --,DS_EMAIL' + sLineBreak + //

     ',' + QuotedStr(FUser.CreatedAt) + ' --,DT_CREATEAT' + sLineBreak + //
     ',' + QuotedStr(FUser.UpdatedAt) + ' --,DT_UPDATEAT' + sLineBreak + //
     ',' + QuotedStr(FUser.LastLogin) + ' --,DT_LASTLOGIN' + sLineBreak + //

     ',' + IntToStr(FUser.EntityId) + ' --,ID_ENTITY' + sLineBreak + //
     ',' + QuotedStr(FUser.EntityName) + ' --,DS_ENTITY' + sLineBreak + //
     ',' + IntToStr(FUser.EntityTypeId) + ' --,ID_ENTITY_TYPE' + sLineBreak + //
     ',' + QuotedStr(FUser.EntityTypeName) + ' --,DS_ENTITY_TYPE' + sLineBreak + //

     ',' + QuotedStr(FUser.TokenType) + ' --,DS_TOKEN_TYPE' + sLineBreak + //
     ',' + QuotedStr(FUser.TokenCredential) + ' --,DS_TOKEN' + sLineBreak + //
     ',' + QuotedStr(FUser.TokenEmission) + ' --,DT_TOKEN' + sLineBreak + //
     ',' + IntToStr(FUser.TokenLifetime) + ' --,NR_TOKEN_LIFETIME' + sLineBreak + //
     ',' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', (IncMinute(JSONDateToDatetime(FUser.TokenEmission), FUser.TokenLifetime)))) + sLineBreak + //

     ')';

  LSQL := StringReplace(LSQL, QuotedStr('null'), 'null', [rfReplaceAll]);

  {$IFDEF DEBUG}
  // LogApp('DEBUG', EmptyStr, LSQL);
  {$ENDIF}
  FQry := TFDQuery.Create(nil);
  try
    FQry.Connection := FDConn;

    try
      FQry.ExecSQL(LSQL);
    except
      on E: Exception do
      begin
        LogApp( //
           'TDM.insereDadosLogin' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(FQry);
    {$ENDIF}
    {$IFDEF ANDROID}
    FQry.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TDM.insereDadosUltimaPosicao(AJsonData: string);
var
  LJsonObject: TJSONObject;
  LJsonValue: TJSONValue;

  FQry: TFDQuery;
  LSQL: string;

  bExists: boolean;

  LId: integer; // 1930,
  LType: string; // Tracking ,
  LEquipmentId: integer; // 3250,
  LEquipmentModelId: integer; // 60,
  LEquipmentModelName: string; // NT20 ,
  LEquipmentBrandId: integer; // 26,
  LEquipmentBrandName: string; // X3Tech ,
  LTerminalId: string; // 0359510081341955 ,
  LFirmwareVersion: string; // null,
  LVehicleId: integer; // null,
  LPlate: string; // null,
  LVehicleTypeId: integer; // null,
  LVehicleTypeName: string; // null,
  LVehicleSubTypeId: integer; // 0,
  LVehicleSubTypeName: string; // Não informado ,
  LVehicleBrandId: integer; // null,
  LVehicleBrandName: string; // null,
  LVehicleModelId: integer; // null,
  LVehicleModelName: string; // null,
  LVehicleColorId: integer; // null,
  LVehicleColor: string; // null,
  LCustomerId: integer; // null,
  LCustomerName: string; // null,
  LSubsidiaryId: integer; // null,
  LEventDate: string; // 2022-11-12T20:49:26.000000Z ,
  LSystemDate: string; // 2022-11-12T20:49:50.000000Z ,
  LLatitude: string; // double; // -23.733922,
  LLongitude: string; // double; // -47.325266,
  LSatellites: integer; // 11,
  LCourse: integer; // 260,
  LIgnitionStatus: boolean; // true,
  LSpeed: integer; // 30,
  LOdometer: integer; // 410,
  LHorimeter: integer; // 1418,
  LPowerVoltage: string; // double; // 13.5,
  LCharge: boolean; // true,
  LBatteryVoltage: integer; // 4,
  LGsmSignalStrength: integer; // 38,
  LInputs: string;
  LOutputs: string;
  LAlarms: string; // None ,
  LAddress: string; // null

begin
  bExists := False;

  LJsonObject := TJSONValue.ParseJSONValue(AJsonData) as TJSONObject;

  LId := StrToIntDef(LJsonObject.Values['id'].Value, 0);

  if (LId = 0) then
  begin
    LogApp('APP: Ultima Posicao nao conseguiu identificar o ID', EmptyStr, EmptyStr);
    Exit;
  end;

  LSQL := //
     'SELECT COUNT(1) AS QTD' + sLineBreak + //
     'FROM POSITIONS_LAST' + sLineBreak + //
     'WHERE 1 = 1' + sLineBreak + //
     'AND ID_POSITION_LAST = ' + IntToStr(LId) + sLineBreak + //
     '';

  {$IFDEF DEBUG}
  // LogApp('DEBUG', EmptyStr, LSQL);
  {$ENDIF}
  FQry := TFDQuery.Create(nil);
  try
    FQry.Connection := FDConn;

    try
      FQry.Open(LSQL);
      bExists := not(FQry.Fields[0].AsInteger = 0);
    except
      on E: Exception do
      begin
        LogApp( //
           'TDM.insereDadosUltimaPosicao' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(FQry);
    {$ENDIF}
    {$IFDEF ANDROID}
    FQry.DisposeOf;
    {$ENDIF}
  end;

  {$IFDEF DEBUG}
  // bExists := False;
  {$ENDIF}
  if not bExists then
  begin
    LType := Trim(LJsonObject.Values['type'].Value);

    LEquipmentId := StrToIntDef(LJsonObject.Values['equipmentid'].Value, 0);
    LEquipmentModelId := StrToIntDef(LJsonObject.Values['equipmentmodelid'].Value, 0);
    LEquipmentModelName := Trim(LJsonObject.Values['equipmentmodelname'].Value);

    LEquipmentBrandId := StrToIntDef(LJsonObject.Values['equipmentbrandid'].Value, 0);
    LEquipmentBrandName := Trim(LJsonObject.Values['equipmentbrandname'].Value);

    LTerminalId := Trim(LJsonObject.Values['terminalid'].Value);
    LFirmwareVersion := Trim(LJsonObject.Values['firmwareversion'].Value);
    LPlate := Trim(LJsonObject.Values['plate'].Value);

    LVehicleId := StrToIntDef(LJsonObject.Values['vehicleid'].Value, 0);

    LVehicleTypeId := StrToIntDef(LJsonObject.Values['vehicletypeid'].Value, 0);
    LVehicleTypeName := Trim(LJsonObject.Values['vehicletypename'].Value);

    LVehicleSubTypeId := StrToIntDef(LJsonObject.Values['vehiclesubtypeid'].Value, 0);
    LVehicleSubTypeName := Trim(LJsonObject.Values['vehiclesubtypename'].Value);

    LVehicleBrandId := StrToIntDef(LJsonObject.Values['vehiclebrandid'].Value, 0);
    LVehicleBrandName := Trim(LJsonObject.Values['vehiclebrandname'].Value);

    LVehicleModelId := StrToIntDef(LJsonObject.Values['vehiclemodelid'].Value, 0);
    LVehicleModelName := Trim(LJsonObject.Values['vehiclemodelname'].Value);

    LVehicleColorId := StrToIntDef(LJsonObject.Values['vehiclecolorid'].Value, 0);
    LVehicleColor := Trim(LJsonObject.Values['vehiclecolor'].Value);

    LCustomerId := StrToIntDef(LJsonObject.Values['customerid'].Value, 0);
    LCustomerName := Trim(LJsonObject.Values['customername'].Value);

    LSubsidiaryId := StrToIntDef(LJsonObject.Values['subsidiaryid'].Value, 0);

    LEventDate := LJsonObject.Values['eventdate'].Value; // JSONDateToDatetime(LJsonObject.Values['eventdate'].Value);
    LSystemDate := LJsonObject.Values['eventdate'].Value; // JSONDateToDatetime(LJsonObject.Values['systemdate'].Value);

    LSatellites := StrToIntDef(LJsonObject.Values['satellites'].Value, 0);
    LLatitude := LJsonObject.Values['latitude'].Value; // StrToFloatDef(StringReplace(LJsonObject.Values['latitude'].Value, '.', ',', [rfReplaceAll]), 0);
    LLongitude := LJsonObject.Values['longitude'].Value; // StrToFloatDef(StringReplace(LJsonObject.Values['longitude'].Value, '.', ',', [rfReplaceAll]), 0);
    LAddress := Trim(LJsonObject.Values['address'].Value);
    LCourse := StrToIntDef(LJsonObject.Values['course'].Value, 0);
    LSpeed := StrToIntDef(LJsonObject.Values['speed'].Value, 0);
    LIgnitionStatus := StrToBool(LJsonObject.Values['ignitionstatus'].Value);

    LOdometer := StrToIntDef(LJsonObject.Values['odometer'].Value, 0);
    LHorimeter := StrToIntDef(LJsonObject.Values['horimeter'].Value, 0);
    LPowerVoltage := LJsonObject.Values['powervoltage'].Value;
    // StrToFloatDef(StringReplace(LJsonObject.Values['powervoltage'].Value, '.', ',', [rfReplaceAll]), 0);
    LCharge := StrToBool(LJsonObject.Values['charge'].Value);
    LBatteryVoltage := StrToIntDef(LJsonObject.Values['batteryvoltage'].Value, 0);
    LGsmSignalStrength := StrToIntDef(LJsonObject.Values['gsmsignalstrength'].Value, 0);

    LInputs := Trim(LJsonObject.Values['inputs'].Value);
    LOutputs := Trim(LJsonObject.Values['outputs'].Value);

    LAlarms := Trim(LJsonObject.Values['alarms'].Value);

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

       IntToStr(FUser.Id) + ' -- ID_USER' + sLineBreak + //
       ',' + IntToStr(LId) + ' -- ,ID_POSITION_LAST' + sLineBreak + //
       ',' + QuotedStr(LType) + ' -- ,DS_TYPE' + sLineBreak + //
       ',' + IntToStr(LEquipmentId) + ' -- ,EQUIPMENT_ID' + sLineBreak + //
       ',' + IntToStr(LEquipmentModelId) + ' -- ,EQUIPMENT_MODEL_ID' + sLineBreak + //
       ',' + QuotedStr(LEquipmentModelName) + ' -- ,EQUIPMENT_MODEL_NAME' + sLineBreak + //
       ',' + IntToStr(LEquipmentBrandId) + ' -- ,EQUIPMENT_BRAND_ID' + sLineBreak + //
       ',' + QuotedStr(LEquipmentBrandName) + ' -- ,EQUIPMENT_BRAND_NAME' + sLineBreak + //
       ',' + QuotedStr(LTerminalId) + ' -- ,TERMINAL_ID' + sLineBreak + //
       ',' + QuotedStr(LFirmwareVersion) + ' -- ,FIRMWARE_VERSION' + sLineBreak + //
       ',' + IntToStr(LVehicleId) + ' -- ,VEHICLE_ID' + sLineBreak + //
       ',' + QuotedStr(LPlate) + ' -- ,PLATE' + sLineBreak + //
       ',' + IntToStr(LVehicleTypeId) + ' -- ,VEHICLE_TYPE_ID' + sLineBreak + //
       ',' + QuotedStr(LVehicleTypeName) + ' -- ,VEHICLE_TYPE_NAME' + sLineBreak + //
       ',' + IntToStr(LVehicleSubTypeId) + ' -- ,VEHICLE_SUB_TYPE_ID' + sLineBreak + //
       ',' + QuotedStr(LVehicleSubTypeName) + ' -- ,VEHICLE_SUB_TYPE_NAME' + sLineBreak + //
       ',' + IntToStr(LVehicleBrandId) + ' -- ,VEHICLE_BRAND_ID' + sLineBreak + //
       ',' + QuotedStr(LVehicleBrandName) + ' -- ,VEHICLE_BRAND_NAME' + sLineBreak + //
       ',' + IntToStr(LVehicleModelId) + ' -- ,VEHICLE_MODEL_ID' + sLineBreak + //
       ',' + QuotedStr(LVehicleModelName) + ' -- ,VEHICLE_MODEL_NAME' + sLineBreak + //
       ',' + IntToStr(LVehicleColorId) + ' -- ,VEHICLE_COLOR_ID' + sLineBreak + //
       ',' + QuotedStr(LVehicleColor) + ' -- ,VEHICLE_COLOR' + sLineBreak + //
       ',' + IntToStr(LCustomerId) + ' -- ,CUSTOMER_ID' + sLineBreak + //
       ',' + QuotedStr(LCustomerName) + ' -- ,CUSTOMER_NAME' + sLineBreak + //
       ',' + IntToStr(LSubsidiaryId) + ' -- ,SUBSIDIARY_ID' + sLineBreak + //
       ',' + QuotedStr(LEventDate) + ' -- ,EVENT_DATE' + sLineBreak + //
       ',' + QuotedStr(LSystemDate) + ' -- ,SYSTEM_DATE' + sLineBreak + //
       ',' + Trim(LLatitude) + ' -- ,LATITUDE' + sLineBreak + //
       ',' + Trim(LLongitude) + ' -- ,LONGITUDE' + sLineBreak + //
       ',' + IntToStr(LSatellites) + ' -- ,SATELLITES' + sLineBreak + //
       ',' + IntToStr(LCourse) + ' -- ,COURSE' + sLineBreak + //
       ',' + QuotedStr(LAddress) + ' -- ,ADDRESS' + sLineBreak + //
       ',' + LowerCase(LIgnitionStatus.ToString) + ' -- ,IGNITION_STATUS' + sLineBreak + //
       ',' + IntToStr(LSpeed) + ' -- ,SPEED' + sLineBreak + //
       ',' + IntToStr(LOdometer) + ' -- ,ODOMETER' + sLineBreak + //
       ',' + IntToStr(LHorimeter) + ' -- ,HORIMETER' + sLineBreak + //
       ',' + Trim(LPowerVoltage) + ' -- ,POWER_VOLTAGE' + sLineBreak + //
       ',' + LowerCase(LCharge.ToString) + ' -- ,CHARGE' + sLineBreak + //
       ',' + IntToStr(LBatteryVoltage) + ' -- ,BATTERY_VOLTAGE' + sLineBreak + //
       ',' + IntToStr(LGsmSignalStrength) + ' -- ,GSM_SIGNAL_STRENGTH' + sLineBreak + //
       ',' + QuotedStr(LInputs) + ' -- ,INPUTS' + sLineBreak + //
       ',' + QuotedStr(LOutputs) + ' -- ,OUTPUTS' + sLineBreak + //
       ',' + QuotedStr(LAlarms) + ' -- ,ALARMS' + sLineBreak + //

       ')';

    LSQL := StringReplace(LSQL, QuotedStr('null'), 'null', [rfReplaceAll]);

    {$IFDEF DEBUG}
    // LogApp('DEBUG', EmptyStr, LSQL);
    {$ENDIF}
    FQry := TFDQuery.Create(nil);
    try
      FQry.Connection := FDConn;

      try
        FQry.ExecSQL(LSQL);
      except
        on E: Exception do
        begin
          LogApp( //
             'TDM.insereDadosUltimaPosicao' //
             , E.ClassName + '. ' + E.Message //
             , LSQL);
        end;
      end;
    finally
      {$IFDEF MSWINDOWS}
      FreeAndNil(FQry);
      {$ENDIF}
      {$IFDEF ANDROID}
      FQry.DisposeOf;
      {$ENDIF}
    end;
  end;
end;

function TDM.doCreateDB: boolean;
var
  LSQL: string;
  LInt: integer;
  LSN: string;
  LNow: string;
  LLat: double;
  LLng: double;
  LDirection: double;

  sLat: string;
  sLng: string;
  sDirection: string;
begin
  // LSQL := 'DROP TABLE IF EXISTS LOGS';
  // FDConn.ExecSQL(LSQL);

  LSQL := //
     'CREATE TABLE IF NOT EXISTS LOGS (' + sLineBreak + //
     'ID_LOG INTEGER PRIMARY KEY AUTOINCREMENT' + sLineBreak + //
     ',DS_LOG TEXT' + sLineBreak + //
     ',DS_ERRO TEXT' + sLineBreak + //
     ',DS_SQL TEXT' + sLineBreak + //
     ',DS_REST VARCHAR(255)' + sLineBreak + //
     ',DS_REST_URI VARCHAR(255)' + sLineBreak + //
     ',DS_REST_PARAM TEXT' + sLineBreak + //
     ',DS_REST_REQUEST TEXT' + sLineBreak + //
     ',DS_REST_RESPONSE TEXT' + sLineBreak + //
     ',DT_REG_INS DATETIME DEFAULT CURRENT_TIMESTAMP' + sLineBreak + //
     ')' + sLineBreak + //
     '';
  FDConn.ExecSQL(LSQL);

  // LSQL := 'DROP TABLE IF EXISTS USERS';
  // FDConn.ExecSQL(LSQL);

  LSQL := //
     'CREATE TABLE IF NOT EXISTS USERS (' + sLineBreak + //
     'ID INTEGER PRIMARY KEY AUTOINCREMENT' + sLineBreak + //
     ',ID_USER INTEGER' + sLineBreak + //
     ',DS_NAME VARCHAR(255)' + sLineBreak + //
     ',DS_ROLE VARCHAR(255)' + sLineBreak + //
     ',ID_GROUP INTEGER' + sLineBreak + //
     ',DS_GROUP VARCHAR(255)' + sLineBreak + //
     ',DS_LOGIN VARCHAR(255)' + sLineBreak + //
     ',DS_PASSWORD VARCHAR(255)' + sLineBreak + //
     ',DS_PHONE VARCHAR(20)' + sLineBreak + //
     ',DS_EMAIL VARCHAR(255)' + sLineBreak + //
     ',DT_CREATEAT DATETIME' + sLineBreak + //
     ',DT_UPDATEAT DATETIME' + sLineBreak + //
     ',DT_LASTLOGIN DATETIME' + sLineBreak + //
     ',ID_ENTITY INTEGER' + sLineBreak + //
     ',DS_ENTITY VARCHAR(255)' + sLineBreak + //
     ',ID_ENTITY_TYPE INTEGER' + sLineBreak + //
     ',DS_ENTITY_TYPE VARCHAR(255)' + sLineBreak + //
     ',DS_TOKEN_TYPE VARCHAR(255)' + sLineBreak + //
     ',DS_TOKEN TEXT' + sLineBreak + //
     ',DT_TOKEN DATETIME' + sLineBreak + //
     ',NR_TOKEN_LIFETIME INTEGER' + sLineBreak + //
     ',DT_TOKEN_EXPIRE DATETIME' + sLineBreak + //
     ',FL_REG_STATUS INTEGER DEFAULT 1' + sLineBreak + //
     ',DT_REG_INS DATETIME DEFAULT CURRENT_TIMESTAMP' + sLineBreak + //
     ',DT_REG_UPD DATETIME' + sLineBreak + //
     ',DT_REG_DEL DATETIME' + sLineBreak + //
     ')' + sLineBreak + //
     '';
  FDConn.ExecSQL(LSQL);

  // LSQL := 'DROP TABLE IF EXISTS POSITIONS_LAST';
  // FDConn.ExecSQL(LSQL);

  LSQL := //
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
  FDConn.ExecSQL(LSQL);

  // LSQL := 'CREATE UNIQUE INDEX IDX_POSITIONS_LAST_ID_POSITION_LAST ON POSITIONS_LAST (ID_POSITION_LAST)';
  // FDConn.ExecSQL(LSQL);
end;

procedure TDM.FDConnBeforeConnect(Sender: TObject);
var
  LDef: IFDStanConnectionDef;
  LParams: TFDPhysSQLiteConnectionDefParams;
  LFile: string;
begin
  {$IFDEF MSWINDOWS}
  LFile := TPath.Combine(ExtractFileDir(ParamStr(0)), cConnDef);
  {$ENDIF}
  {$IFDEF ANDROID}
  LFile := TPath.Combine(TPath.GetDocumentsPath, cConnDef);
  {$ENDIF}
  FDManager.ConnectionDefFileName := LFile;
  FDManager.ConnectionDefFileAutoLoad := True;

  if not FDManager.IsConnectionDef(cNameConnDef) then
  begin
    FDManager.ConnectionDefs.AddConnectionDef;
    LDef := FDManager.ConnectionDefs.AddConnectionDef;
  end
  else
  begin
    LDef := FDManager.ConnectionDefs.FindConnectionDef(cNameConnDef);
  end;

  LDef.Name := cNameConnDef;

  LParams := TFDPhysSQLiteConnectionDefParams(LDef.Params);
  LParams.DriverID := 'SQLite';
  {$IFDEF MSWINDOWS}
  LParams.Database := TPath.Combine(ExtractFileDir(ParamStr(0)), 'mobile.sdb');
  {$ENDIF}
  {$IFDEF ANDROID}
  LParams.Database := TPath.Combine(TPath.GetDocumentsPath, 'mobile.sdb');
  {$ENDIF}
  LParams.LockingMode := lmNormal;
  LParams.SQLiteAdvanced := 'temp_store=MEMORY;page_size=8192;auto_vacuum=FULL';

  LDef.MarkPersistent;
  LDef.Apply;

  FDConn.LoginPrompt := False;
  FDConn.FetchOptions.Mode := fmAll;
  FDConn.ResourceOptions.SilentMode := True;
  FDConn.ConnectionDefName := cNameConnDef;

end;

end.
