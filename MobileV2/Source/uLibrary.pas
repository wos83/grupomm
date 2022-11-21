unit uLibrary;

interface

uses
  Data.DB,
  FireDAC.Comp.Client,
  //
  System.Classes,
  System.DateUtils,
  System.SysConst,
  System.SysUtils,
  System.StrUtils,
  //
  {$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Widget,
  FMX.Helpers.Android,
  FMX.Platform.Android,
  {$ENDIF}
  //
  FMX.DialogService;

procedure LogApp(ARegistro, AErro: string); overload;
procedure LogApp(ARegistro, AErro, AInstrucaoSQL: string); overload;
procedure LogApp(ARegistro, AErro, AInstrucaoSQL, ARequisicaoREST, ARequisicaoURI, ARequisicaoParam, ARequisicaoJSON, ARespostaJSON: string); overload;

function GenerateRandomStringOnlyLetter(ALength: Integer): String;
function GenerateRandomStringOnlyNumber(ALength: Integer): String;

procedure Toast(const Msg: string; Duration: Integer);

function CountWords(AWord, AText: String): Integer;
function JSONDateToDatetime(AJSONDate: string): TDatetime;
function SpaceBlank(ACount: Integer): string;

implementation

uses
  uDM;

procedure LogApp(ARegistro, AErro: string);
var
  LQry: TFDQuery;
  LSQL: string;
  LError: string;
begin
  {$IFDEF DEBUG}
  LQry := TFDQuery.Create(nil);
  try
    LSQL := 'INSERT INTO LOGS (DS_LOG,DS_ERRO,DS_SQL) VALUES (:DS_LOG,:DS_ERRO,:DS_SQL)';
    LQry.Name := 'QryTemp' + FormatDateTime('yyyymddhhnnsszzz', Now);
    LQry.Close;
    LQry.Connection := DM.FDConn;
    LQry.SQL.Clear;
    LQry.SQL.Text := Trim(LSQL);
    try
      LQry.Params.ParamByName('DS_LOG').AsString := Trim(ARegistro);
      LQry.Params.ParamByName('DS_ERRO').AsString := Trim(AErro);
      LQry.ExecSQL;
    except
      on E: Exception do
      begin
        LError := 'Error: ' + E.ClassName + '. ' + E.Message + sLineBreak + LSQL;
        TDialogService.ShowMessage(LError);
        Exit;
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LQry);
    {$ENDIF}
    {$IFDEF ANDROID}
    LQry.DisposeOf;
    {$ENDIF}
  end;
  {$ENDIF}
end;

procedure LogApp(ARegistro, AErro, AInstrucaoSQL: string);
var
  LQry: TFDQuery;
  LSQL: string;
  LError: string;
begin
  {$IFDEF DEBUG}
  LQry := TFDQuery.Create(nil);
  try
    LSQL := 'INSERT INTO LOGS (DS_LOG,DS_ERRO,DS_SQL) VALUES (:DS_LOG,:DS_ERRO,:DS_SQL)';

    LQry.Name := 'QryTemp' + FormatDateTime('yyyymddhhnnsszzz', Now);
    LQry.Close;
    LQry.Connection := DM.FDConn;
    LQry.SQL.Clear;
    LQry.SQL.Text := Trim(LSQL);
    try
      LQry.Params.ParamByName('DS_LOG').AsString := Trim(ARegistro);
      LQry.Params.ParamByName('DS_ERRO').AsString := Trim(AErro);
      LQry.Params.ParamByName('DS_SQL').AsString := Trim(AInstrucaoSQL);
      LQry.ExecSQL;
    except
      on E: Exception do
      begin
        LError := 'Error: ' + E.ClassName + '. ' + E.Message + sLineBreak + LSQL;
        TDialogService.ShowMessage(LError);
        Exit;
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LQry);
    {$ENDIF}
    {$IFDEF ANDROID}
    LQry.DisposeOf;
    {$ENDIF}
  end;
  {$ENDIF}
end;

procedure LogApp(ARegistro, AErro, AInstrucaoSQL, ARequisicaoREST, ARequisicaoURI, ARequisicaoParam, ARequisicaoJSON, ARespostaJSON: string);
var
  LQry: TFDQuery;
  LSQL: string;
  LError: string;
begin
  {$IFDEF DEBUG}
  LQry := TFDQuery.Create(nil);
  try
    LSQL := //
       'INSERT INTO LOGS (' + sLineBreak + //
       'DS_LOG,DS_ERRO,DS_SQL,DS_REST,DS_REST_URI,DS_REST_PARAM,DS_REST_REQUEST,DS_REST_RESPONSE' + sLineBreak + //
       ') VALUES (' + sLineBreak + //
       ':DS_LOG,:DS_ERRO,:DS_SQL,:DS_REST,:DS_REST_URI,:DS_REST_PARAM,:DS_REST_REQUEST,:DS_REST_RESPONSE' + sLineBreak + //
       ')';

    LQry.Name := 'QryTemp' + FormatDateTime('yyyymddhhnnsszzz', Now);
    LQry.Close;
    LQry.Connection := DM.FDConn;
    LQry.SQL.Clear;
    LQry.SQL.Text := Trim(LSQL);
    try
      LQry.Params.ParamByName('DS_LOG').AsString := Trim(ARegistro);
      LQry.Params.ParamByName('DS_ERRO').AsString := Trim(AErro);
      LQry.Params.ParamByName('DS_SQL').AsString := Trim(AInstrucaoSQL);
      LQry.Params.ParamByName('DS_REST').AsString := Trim(ARequisicaoREST);
      LQry.Params.ParamByName('DS_REST_URI').AsString := Trim(ARequisicaoURI);
      LQry.Params.ParamByName('DS_REST_PARAM').AsString := Trim(ARequisicaoParam);
      LQry.Params.ParamByName('DS_REST_REQUEST').AsString := Trim(ARequisicaoJSON);
      LQry.Params.ParamByName('DS_REST_RESPONSE').AsString := Trim(ARespostaJSON);
      LQry.ExecSQL;
    except
      on E: Exception do
      begin
        LError := 'Error: ' + E.ClassName + '. ' + E.Message + sLineBreak + LSQL;
        TDialogService.ShowMessage(LError);
        Exit;
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    FreeAndNil(LQry);
    {$ENDIF}
    {$IFDEF ANDROID}
    LQry.DisposeOf;
    {$ENDIF}
  end;
  {$ENDIF}
end;

function GenerateRandomStringOnlyLetter(ALength: Integer): String;
var
  Ch, SequenceLength: Integer;
const
  CharSequence = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
begin
  SequenceLength := Length(CharSequence);
  SetLength(Result, ALength);
  Randomize;
  for Ch := Low(Result) to High(Result) do
    Result[Ch] := CharSequence.Chars[Random(SequenceLength)];
end;

function GenerateRandomStringOnlyNumber(ALength: Integer): String;
var
  Ch, SequenceLength: Integer;
const
  CharSequence = '0123456789';
begin
  SequenceLength := Length(CharSequence);
  SetLength(Result, ALength);
  Randomize;
  for Ch := Low(Result) to High(Result) do
    Result[Ch] := CharSequence.Chars[Random(SequenceLength)];
end;

procedure Toast(const Msg: string; Duration: Integer);
begin
  // {$IFDEF MSWINDOWS}
  // Tthread.Queue(nil,
  // procedure
  // begin
  // TDialogService.ShowMessage(Msg);
  // end);
  // {$ENDIF}
  {$IFDEF ANDROID}
  CallInUiThread(
    procedure
    begin
      TJToast.JavaClass.makeText(TAndroidHelper.Context //
         , StrToJCharSequence(Msg), Duration).show;
    end);
  {$ENDIF}
end;

function CountWords(AWord, AText: String): Integer;
var
  LCount: Integer;
begin
  Result := 0;
  LCount := Pos(AWord, AText);
  while LCount > 0 do
  begin
    Inc(Result);
    AText := Copy(AText, LCount + Length(AWord), Length(AText));
    LCount := Pos(AWord, AText);
  end;
end;

function JSONDateToDatetime(AJSONDate: string): TDatetime;
var
  Year, Month, Day, Hour, Minute, Second, Millisecond: Word;
begin
  // AJSONDate := '2099-12-31T23:59:59.999999Z'; //Exemplo do Json DateTime

  Year := StrToInt(Copy(AJSONDate, 1, 4));
  Month := StrToInt(Copy(AJSONDate, 6, 2));
  Day := StrToInt(Copy(AJSONDate, 9, 2));
  Hour := StrToInt(Copy(AJSONDate, 12, 2));
  Minute := StrToInt(Copy(AJSONDate, 15, 2));
  Second := StrToInt(Copy(AJSONDate, 18, 2));
  Millisecond := 0; // Round(StrToFloat(Copy(AJSONDate, 21, 6)));

  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond);
end;

function SpaceBlank(ACount: Integer): string;
var
  LInt: integer;
begin
  Result := EmptyStr;
  for LInt := 0 to Pred(ACount) do
    Result := Result + #32;
end;

end.
