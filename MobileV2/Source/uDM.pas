unit uDM;

interface

uses
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Data.DB,
  //
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
  System.Sensors,
  System.Sensors.Components,
  System.StrUtils,
  System.SysUtils,
  //
  uLog,
  uLoading,
  uConsts,
  uLibrary,
  uUser,
  uLogin,
  uPositionHistory,
  uPositionLast;

type
  TDM = class(TDataModule)
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDConn: TFDConnection;

    procedure FDConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    function doCreateDB: boolean;
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

function TDM.doCreateDB: boolean;
var
  LSQL: string;
  LError: string;
begin
  if not Logg.CreateTableLogs then
  begin
    LError := 'Não foi possível criar a tabela de Logs.';
    TDialogService.ShowMessage(LError);
    Logg.LogDebug(LError);
    Exit;
  end;

  if not User.CreateTableUsers then
  begin
    LError := 'Não foi possível criar a tabela de Usuários.';
    TDialogService.ShowMessage(LError);
    Logg.LogDebug(LError);
    Exit;
  end;

  if not PositionLast.CreateTablePositionLast then
  begin
    LError := 'Não foi possível criar a tabela da Última Posição.';
    TDialogService.ShowMessage(LError);
    Logg.LogDebug(LError);
    Exit;
  end;

  if not PositionHistory.CreateTablePositionHistory then
  begin
    LError := 'Não foi possível criar a tabela de Histórico de Posição.';
    TDialogService.ShowMessage(LError);
    Logg.LogDebug(LError);
    Exit;
  end;
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
  {$IFDEF DEBUG}
  Logg.LogDebug('Arquivo de Configuração do Banco de Dados Local: (SQLite): ' + LFile);
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
  {$IFDEF DEBUG}
  Logg.LogDebug('Arquivo do Banco de Dados Local: (SQLite): ' + LParams.Database);
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
