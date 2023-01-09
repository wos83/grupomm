unit uLogin;

interface

uses
  FireDAC.Comp.Client,

  System.Classes,
  System.DateUtils,
  System.SysUtils,

  RESTRequest4D,

  uLog,
  uConsts,
  uLibrary;

type
  TLogin = class
  private
    { Private declarations }
  public
    function doLogin(AUsername, APassword, AUUID: string; out AError: string): boolean;
    procedure saveData;
    { Public declarations }
  end;

var
  Login: TLogin;

const
  cBody = '{"username":"%s","password":"%s","uuid":"%s"}';

implementation

uses
  uDM,
  uUser;

function TLogin.doLogin(AUsername, APassword, AUUID: string; out AError: string): boolean;
var
  LResponse: IResponse;
begin
  Result := False;
  AError := EmptyStr;

  try
    LResponse := //
       TRequest.New.BaseURL(cAPI + cAPI_Login) //
       .Accept(cAppJson) //
       .AddBody(Format(cBody, [AUsername, APassword, cUUID])) //
       .Post;
  except
    on E: Exception do
    begin
      Logg.LogApp( //
         'TLogin.doLogin' //
         , E.ClassName + '. ' + E.Message);

      Logg.LogDebug( //
         'TLogin.doLogin' + sLineBreak + //
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
           'DEBUG: TLogin.doLogin' //
           , EmptyStr //
           , EmptyStr //
           , 'POST' //
           , cAPI + cAPI_Login //
           , LResponse.Headers.Text //
           , Format(cBody, [AUsername, APassword, cUUID]) //
           , LResponse.JSONValue.ToString);

        Logg.LogDebug( //
           'DEBUG: TLogin.doLogin' + sLineBreak + //
           'POST' + sLineBreak + //
           cAPI + cAPI_Login + sLineBreak + //
           LResponse.Headers.Text + sLineBreak + //
           Format(cBody, [AUsername, APassword, cUUID]) + sLineBreak + //
           LResponse.JSONValue.ToString + sLineBreak + //
           '');
        {$ENDIF}
        {$REGION 'Preenche as Informações do Usuário Logado'}
        User.Id := StrToIntDef(LResponse.JSONValue.FindValue('id').Value, 0);
        User.Username := LResponse.JSONValue.FindValue('username').Value;
        User.Password := APassword;
        User.Name := LResponse.JSONValue.FindValue('name').Value;
        User.Mobile := LResponse.JSONValue.FindValue('phonenumber').Value;
        User.Email := LResponse.JSONValue.FindValue('email').Value;
        User.Role := LResponse.JSONValue.FindValue('role').Value;

        User.CreatedAt := LResponse.JSONValue.FindValue('createdat').Value;
        User.UpdatedAt := LResponse.JSONValue.FindValue('updatedat').Value;
        User.LastLogin := LResponse.JSONValue.FindValue('lastlogin').Value;

        User.GroupId := StrToIntDef(LResponse.JSONValue.FindValue('groupid').Value, 0);
        User.GroupName := LResponse.JSONValue.FindValue('groupname').Value;

        User.EntityId := StrToIntDef(LResponse.JSONValue.FindValue('entity.id').Value, 0);
        User.EntityName := LResponse.JSONValue.FindValue('entity.name').Value;

        User.EntityTypeId := StrToIntDef(LResponse.JSONValue.FindValue('entity.entitytypeid').Value, 0);
        User.EntityTypeName := LResponse.JSONValue.FindValue('entity.entitytypename').Value;

        User.Cooperative := StrToBoolDef(LResponse.JSONValue.FindValue('entity.cooperative').Value, False);
        User.JuridicalPerson := StrToBoolDef(LResponse.JSONValue.FindValue('entity.juridicalperson').Value, False);

        User.TokenType := LResponse.JSONValue.FindValue('token.type').Value;
        User.TokenCredential := LResponse.JSONValue.FindValue('token.credential').Value;
        User.TokenEmission := LResponse.JSONValue.FindValue('token.emission').Value;
        User.TokenLifetime := StrToIntDef(LResponse.JSONValue.FindValue('token.lifetime').Value, 0);
        {$ENDREGION}
        TThread.Queue(nil,
          procedure
          begin
            saveData;
          end);

        Result := True;
      end;
  else
    begin
      AError := //
         'Erro ' + LResponse.StatusCode.ToString + ': ' + LResponse.StatusText + sLineBreak + //
         'Título: ' + LResponse.JSONValue.FindValue('title').Value + sLineBreak + //
         'Detalhe: ' + LResponse.JSONValue.FindValue('detail').Value + sLineBreak + //
         'Endpoint: ' + LResponse.JSONValue.FindValue('instance').Value;

      Logg.LogApp( //
         'TLogin.doLogin' //
         , AError);

      Logg.LogDebug( //
         'TLogin.doLogin' + sLineBreak + //
         AError + sLineBreak + //
         '');
    end;
  end;
end;

procedure TLogin.saveData;
var
  LQry: TFDQuery;
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

     IntToStr(User.Id) + ' --ID_USER' + sLineBreak + //
     ',' + QuotedStr(User.Name) + ' --,DS_NAME' + sLineBreak + //
     ',' + QuotedStr(User.Role) + ' --,DS_ROLE' + sLineBreak + //
     ',' + IntToStr(User.GroupId) + ' --,ID_GROUP' + sLineBreak + //
     ',' + QuotedStr(User.GroupName) + ' --,DS_GROUP' + sLineBreak + //
     ',' + QuotedStr(User.Username) + ' --,DS_LOGIN' + sLineBreak + //
     ',' + QuotedStr(User.Password) + ' --,DS_PASSWORD' + sLineBreak + //
     ',' + QuotedStr(User.Mobile) + ' --,DS_PHONE' + sLineBreak + //
     ',' + QuotedStr(User.Email) + ' --,DS_EMAIL' + sLineBreak + //

     ',' + QuotedStr(User.CreatedAt) + ' --,DT_CREATEAT' + sLineBreak + //
     ',' + QuotedStr(User.UpdatedAt) + ' --,DT_UPDATEAT' + sLineBreak + //
     ',' + QuotedStr(User.LastLogin) + ' --,DT_LASTLOGIN' + sLineBreak + //

     ',' + IntToStr(User.EntityId) + ' --,ID_ENTITY' + sLineBreak + //
     ',' + QuotedStr(User.EntityName) + ' --,DS_ENTITY' + sLineBreak + //
     ',' + IntToStr(User.EntityTypeId) + ' --,ID_ENTITY_TYPE' + sLineBreak + //
     ',' + QuotedStr(User.EntityTypeName) + ' --,DS_ENTITY_TYPE' + sLineBreak + //

     ',' + QuotedStr(User.TokenType) + ' --,DS_TOKEN_TYPE' + sLineBreak + //
     ',' + QuotedStr(User.TokenCredential) + ' --,DS_TOKEN' + sLineBreak + //
     ',' + QuotedStr(User.TokenEmission) + ' --,DT_TOKEN' + sLineBreak + //
     ',' + IntToStr(User.TokenLifetime) + ' --,NR_TOKEN_LIFETIME' + sLineBreak + //
     ',' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', (IncMinute(JSONDateToDatetime(User.TokenEmission), User.TokenLifetime)))) + sLineBreak + //

     ')';

  LSQL := StringReplace(LSQL, QuotedStr('null'), 'null', [rfReplaceAll]);

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TLogin.saveData', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TLogin.saveData' + sLineBreak + LSQL);
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
           'TLogin.saveData' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TLogin.saveData' + sLineBreak + //
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
