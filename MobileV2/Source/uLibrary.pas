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
  System.NetEncoding,
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
  FMX.Graphics,
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
function RosaDosVentos(ACourse: Integer; AOnlyIcon: boolean): string; overload;
function RosaDosVentos(ACourse: Integer): string; overload;

function Base64FromBitmap(Bitmap: TBitmap): string;
procedure BitmapFromBase64(Base64: string; Bitmap: TBitmap);

function PadL(AString: String; AInt: Integer; AChar: char): String;
function PadR(AString: String; AInt: Integer; AChar: char): String;

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
  LInt: Integer;
begin
  Result := EmptyStr;
  for LInt := 0 to Pred(ACount) do
    Result := Result + #32;
end;

function RosaDosVentos(ACourse: Integer; AOnlyIcon: boolean): string;
begin
  begin
    case ACourse of
      000 .. 022:
        begin
          if not AOnlyIcon then
            Result := '↗️ ' + ACourse.ToString + '° N'
          else
            Result := '↗️ ';
        end;
      023 .. 045:
        begin
          if not AOnlyIcon then
            Result := '↗️ ' + ACourse.ToString + '° NNE'
          else
            Result := '↗️ ';
        end;
      046 .. 067:
        begin
          if not AOnlyIcon then
            Result := '↗️ ' + ACourse.ToString + '° NE'
          else
            Result := '↗️ ';
        end;
      068 .. 090:
        begin
          if not AOnlyIcon then
            Result := '➡️' + ACourse.ToString + '° ENE'
          else
            Result := '➡️';
        end;
      091 .. 112:
        begin
          if not AOnlyIcon then
            Result := '↘️ ' + ACourse.ToString + '° E'
          else
            Result := '↘️ ';
        end;
      113 .. 135:
        begin
          if not AOnlyIcon then
            Result := '↘️ ' + ACourse.ToString + '° ESE'
          else
            Result := '↘️ ';
        end;
      136 .. 157:
        begin
          if not AOnlyIcon then
            Result := '↘️ ' + ACourse.ToString + '° SE'
          else
            Result := '↘️ ';
        end;
      158 .. 180:
        begin
          if not AOnlyIcon then
            Result := '⬇️ ' + ACourse.ToString + '° SSE'
          else
            Result := '⬇️ ';
        end;
      181 .. 202:
        begin
          if not AOnlyIcon then
            Result := '↙️ ' + ACourse.ToString + '° S'
          else
            Result := '↙️ ';
        end;
      203 .. 225:
        begin
          if not AOnlyIcon then
            Result := '↙️ ' + ACourse.ToString + '° SSO'
          else
            Result := '↙️ ';
        end;
      226 .. 247:
        begin
          if not AOnlyIcon then
            Result := '↗️ ' + ACourse.ToString + '° SO'
          else
            Result := '↗️ ';
        end;
      248 .. 270:
        begin
          if not AOnlyIcon then
            Result := '⬅️ ' + ACourse.ToString + '° OSO'
          else
            Result := '⬅️ ';
        end;
      271 .. 292:
        begin
          if not AOnlyIcon then
            Result := '↖️ ' + ACourse.ToString + '° O'
          else
            Result := '↖️ ';
        end;
      293 .. 315:
        begin
          if not AOnlyIcon then
            Result := '↖️ ' + ACourse.ToString + '° ONO'
          else
            Result := '↖️ ';
        end;
      316 .. 337:
        begin
          if not AOnlyIcon then
            Result := '↖️ ' + ACourse.ToString + '° NNO'
          else
            Result := '↖️ ';
        end;
      338 .. 360:
        begin
          if not AOnlyIcon then
            Result := '⬆️ ' + ACourse.ToString + '° N'
          else
            Result := '⬆️ ';
        end;
    end;
  end;
end;

function RosaDosVentos(ACourse: Integer): string;
begin
  case ACourse of
    000 .. 022:
      Result := '⬆️ ' + ACourse.ToString + '° N';
    023 .. 045:
      Result := '↗️ ' + ACourse.ToString + '° NNE';
    046 .. 067:
      Result := '↗️ ' + ACourse.ToString + '° NE';
    068 .. 090:
      Result := '➡️' + ACourse.ToString + '° ENE';
    091 .. 112:
      Result := '➡️' + ACourse.ToString + '° E';
    113 .. 135:
      Result := '↘️ ' + ACourse.ToString + '° ESE';
    136 .. 157:
      Result := '↘️ ' + ACourse.ToString + '° SE';
    158 .. 180:
      Result := '⬇️ ' + ACourse.ToString + '° SSE';
    181 .. 202:
      Result := '⬇️ ' + ACourse.ToString + '° S';
    203 .. 225:
      Result := '↙️ ' + ACourse.ToString + '° SSO';
    226 .. 247:
      Result := '↙️ ' + ACourse.ToString + '° SO';
    248 .. 270:
      Result := '⬅️ ' + ACourse.ToString + '° OSO';
    271 .. 292:
      Result := '⬅️ ' + ACourse.ToString + '° O';
    293 .. 315:
      Result := '↖️ ' + ACourse.ToString + '° ONO';
    316 .. 337:
      Result := '↖️ ' + ACourse.ToString + '° NNO';
    338 .. 360:
      Result := '⬆️ ' + ACourse.ToString + '° N';
  end;
end;

function Base64FromBitmap(Bitmap: TBitmap): string;
var
  Stream: TBytesStream;
  Encoding: TBase64Encoding;
begin
  Stream := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Stream);
    Encoding := TBase64Encoding.Create(0);
    try
      Result := Encoding.EncodeBytesToString(Copy(Stream.Bytes, 0, Stream.Size));
    finally
      Encoding.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure BitmapFromBase64(Base64: string; Bitmap: TBitmap);
var
  Stream: TBytesStream;
  Bytes: TBytes;
  Encoding: TBase64Encoding;
begin
  Stream := TBytesStream.Create;
  try
    Encoding := TBase64Encoding.Create(0);
    try
      Bytes := Encoding.DecodeStringToBytes(Base64);
      Stream.WriteData(Bytes, Length(Bytes));
      Stream.Position := 0;
      Bitmap.LoadFromStream(Stream);
    finally
      Encoding.Free;
    end;
  finally
    Stream.Free;
  end;
end;

function PadL(AString: String; AInt: Integer; AChar: char): String;
begin
  AString := Trim(AString);
  Result := StringOfChar(AChar, AInt - Length(AString)) + AString;
end;

function PadR(AString: String; AInt: Integer; AChar: char): String;
begin
  AString := Trim(AString);
  Result := AString + StringOfChar(AChar, AInt - Length(AString));
end;

end.
