unit uUser;

interface

uses
  FireDAC.Comp.Client,

  System.Classes,
  System.SysUtils,

  uLog,
  uConsts;

type
  TUser = class
  private
    { Private declarations }
  public
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

    function CreateTableUsers: boolean;
    { Public declarations }
  end;

var
  User: TUser;

const
  SQL_CREATE_TABLE_USERS = //
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
     ',FL_LOGGED INTEGER DEFAULT 1' + sLineBreak + //
     ',FL_REG_STATUS INTEGER DEFAULT 1' + sLineBreak + //
     ',DT_REG_INS DATETIME DEFAULT CURRENT_TIMESTAMP' + sLineBreak + //
     ',DT_REG_UPD DATETIME' + sLineBreak + //
     ',DT_REG_DEL DATETIME' + sLineBreak + //
     ')' + sLineBreak + //
     '';

implementation

uses
  uDM;

function TUser.CreateTableUsers: boolean;
var
  LQry: TFDQuery;
  LSQL: string;
begin
  Result := False;
  LSQL := SQL_CREATE_TABLE_USERS;

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TUser.CreateTableUsers', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TUser.CreateTableUsers' + sLineBreak + LSQL);
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
           'TUser.CreateTableUsers' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TUser.CreateTableUsers' + sLineBreak + //
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
