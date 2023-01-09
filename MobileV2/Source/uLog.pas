unit uLog;

interface

uses
  FireDAC.Comp.Client,
  System.Classes,
  System.SysUtils,
  System.IOUtils,
  uConsts;

type
  TLog = class
  private
    { Private declarations }
  public
    function CreateTableLogs: boolean;

    procedure LogDebug(ADescription: string);

    procedure LogApp(ADescription, AError: string);
    procedure LogAppSQL(ADescription, AError, ASQL: string);
    procedure LogAppREST(ADescription, AError, ASQL, AMethod, AURI, AParam, ARequestJSON, AResponseJSON: string);
    { Public declarations }
  end;

var
  Logg: TLog;

const
  SQL_CREATE_TABLE_LOGS = //
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

implementation

uses
  uDM;

function TLog.CreateTableLogs: boolean;
var
  LQry: TFDQuery;
  LSQL: string;
begin
  Result := False;
  LSQL := SQL_CREATE_TABLE_LOGS;

  {$IFDEF DEBUG}
  Logg.LogAppSQL('DEBUG: TLog.CreateTableLogs', EmptyStr, LSQL);
  Logg.LogDebug('DEBUG: TLog.CreateTableLogs' + sLineBreak + LSQL);
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
           'TLog.CreateTableLogs' //
           , E.ClassName + '. ' + E.Message //
           , LSQL);

        Logg.LogDebug( //
           'TLog.CreateTableLogs' + sLineBreak + //
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

procedure TLog.LogDebug(ADescription: string);
var
  LNow: string;
  LFile: string;
  LDir: string;
  LPath: string;
  LSL: TStringList;
const
  cLogFile = cAppName + '_%s.log';
begin
  // LNow := FormatDateTime('yyyymmdd', Now);
  // LFile := Format(cLogFile, [LNow]);
  //
  // {$IFDEF MSWINDOWS}
  // LDir := ExtractFileDir(ParamStr(0)) + PathDelim + cLOG;
  // {$ENDIF}
  // {$IFDEF ANDROID}
  // LDir := TPath.GetSharedDocumentsPath + PathDelim + cAppName + PathDelim + cLOG;
  // {$ENDIF}
  // LPath := TPath.Combine(LDir, LFile);
  //
  // if not DirectoryExists(LDir) then
  // ForceDirectories(LDir);
  //
  // LSL := TStringList.Create;
  // try
  // if FileExists(LPath) then
  // LSL.LoadFromFile(LPath, TEncoding.UTF8);
  //
  // LNow := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now);
  // LSL.Insert(0, LNow + ' ' + Trim(ADescription));
  //
  // LSL.SaveToFile(LPath, TEncoding.UTF8);
  // finally
  // {$IFDEF MSWINDOWS}
  // FreeAndNil(LSL);
  // {$ELSE}
  // LSL.DisposeOf;
  // {$ENDIF}
  // end;
end;

procedure TLog.LogApp(ADescription, AError: string);
var
  LQry: TFDQuery;
  LSQL: string;
  LError: string;
begin
  // {$IFDEF DEBUG}
  // LQry := TFDQuery.Create(nil);
  // try
  // LSQL := 'INSERT INTO LOGS (DS_LOG,DS_ERRO) VALUES (:DS_LOG,:DS_ERRO)';
  // LQry.Name := 'QryTemp' + FormatDateTime('yyyymddhhnnsszzz', Now);
  // LQry.Close;
  // LQry.Connection := DM.FDConn;
  // LQry.SQL.Clear;
  // LQry.SQL.Text := Trim(LSQL);
  //
  // Logg.LogDebug('DEBUG: TLog.LogApp' + sLineBreak + LSQL);
  //
  // try
  // LQry.Params.ParamByName('DS_LOG').AsString := Trim(ADescription);
  // LQry.Params.ParamByName('DS_ERRO').AsString := Trim(AError);
  // LQry.ExecSQL;
  // except
  // on E: Exception do
  // begin
  // LError := 'Error: ' + E.ClassName + '. ' + E.Message + sLineBreak + LSQL;
  // Logg.LogDebug(LError);
  // Exit;
  // end;
  // end;
  // finally
  // {$IFDEF MSWINDOWS}
  // FreeAndNil(LQry);
  // {$ENDIF}
  // {$IFDEF ANDROID}
  // LQry.DisposeOf;
  // {$ENDIF}
  // end;
  // {$ENDIF}
end;

procedure TLog.LogAppSQL(ADescription, AError, ASQL: string);
var
  LQry: TFDQuery;
  LSQL: string;
  LError: string;
begin
  // {$IFDEF DEBUG}
  // LQry := TFDQuery.Create(nil);
  // try
  // LSQL := 'INSERT INTO LOGS (DS_LOG,DS_ERRO,DS_SQL) VALUES (:DS_LOG,:DS_ERRO,:DS_SQL)';
  //
  // LQry.Name := 'QryTemp' + FormatDateTime('yyyymddhhnnsszzz', Now);
  // LQry.Close;
  // LQry.Connection := DM.FDConn;
  // LQry.SQL.Clear;
  // LQry.SQL.Text := Trim(LSQL);
  //
  // Logg.LogDebug('DEBUG: TLog.LogAppSQL' + sLineBreak + LSQL);
  //
  // try
  // LQry.Params.ParamByName('DS_LOG').AsString := Trim(ADescription);
  // LQry.Params.ParamByName('DS_ERRO').AsString := Trim(AError);
  // LQry.Params.ParamByName('DS_SQL').AsString := Trim(ASQL);
  // LQry.ExecSQL;
  // except
  // on E: Exception do
  // begin
  // LError := 'Error: ' + E.ClassName + '. ' + E.Message + sLineBreak + LSQL;
  // LogDebug(LError);
  // Exit;
  // end;
  // end;
  // finally
  // {$IFDEF MSWINDOWS}
  // FreeAndNil(LQry);
  // {$ENDIF}
  // {$IFDEF ANDROID}
  // LQry.DisposeOf;
  // {$ENDIF}
  // end;
  // {$ENDIF}
end;

procedure TLog.LogAppREST(ADescription, AError, ASQL, AMethod, AURI, AParam, ARequestJSON, AResponseJSON: string);
var
  LQry: TFDQuery;
  LSQL: string;
  LError: string;
begin
  // {$IFDEF DEBUG}
  // LQry := TFDQuery.Create(nil);
  // try
  // LSQL := //
  // 'INSERT INTO LOGS (' + sLineBreak + //
  // 'DS_LOG,DS_ERRO,DS_SQL,DS_REST,DS_REST_URI,DS_REST_PARAM,DS_REST_REQUEST,DS_REST_RESPONSE' + sLineBreak + //
  // ') VALUES (' + sLineBreak + //
  // ':DS_LOG,:DS_ERRO,:DS_SQL,:DS_REST,:DS_REST_URI,:DS_REST_PARAM,:DS_REST_REQUEST,:DS_REST_RESPONSE' + sLineBreak + //
  // ')';
  //
  // LQry.Name := 'QryTemp' + FormatDateTime('yyyymddhhnnsszzz', Now);
  // LQry.Close;
  // LQry.Connection := DM.FDConn;
  // LQry.SQL.Clear;
  // LQry.SQL.Text := Trim(LSQL);
  //
  // Logg.LogDebug('DEBUG: TLog.LogAppREST' + sLineBreak + LSQL);
  //
  // try
  // LQry.Params.ParamByName('DS_LOG').AsString := Trim(ADescription);
  // LQry.Params.ParamByName('DS_ERRO').AsString := Trim(AError);
  // LQry.Params.ParamByName('DS_SQL').AsString := Trim(ASQL);
  // LQry.Params.ParamByName('DS_REST').AsString := Trim(AMethod);
  // LQry.Params.ParamByName('DS_REST_URI').AsString := Trim(AURI);
  // LQry.Params.ParamByName('DS_REST_PARAM').AsString := Trim(AParam);
  // LQry.Params.ParamByName('DS_REST_REQUEST').AsString := Trim(ARequestJSON);
  // LQry.Params.ParamByName('DS_REST_RESPONSE').AsString := Trim(AResponseJSON);
  // LQry.ExecSQL;
  // except
  // on E: Exception do
  // begin
  // LError := 'Error: ' + E.ClassName + '. ' + E.Message + sLineBreak + LSQL;
  // LogDebug(LError);
  // Exit;
  // end;
  // end;
  // finally
  // {$IFDEF MSWINDOWS}
  // FreeAndNil(LQry);
  // {$ENDIF}
  // {$IFDEF ANDROID}
  // LQry.DisposeOf;
  // {$ENDIF}
  // end;
  // {$ENDIF}
end;

end.
