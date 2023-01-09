unit uDM;

interface

uses
  AndroidApi.JNI.App,
  AndroidApi.JNI.GraphicsContentViewText,
  AndroidApi.JNI.Os,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  FireDAC.ConsoleUI.Wait,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
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
  REST.Client,
  REST.Types,
  System.Android.Service,
  System.Classes,
  System.Generics.Collections,
  System.IOUtils,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.HttpClient.Android,
  System.Net.URLClient,
  System.SyncObjs,
  System.SysUtils,
  //
  uConsts,
  uUser;

type
  TThreadUpdate = class;

  TDM = class(TAndroidService)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;

    function AndroidServiceBind(const Sender: TObject; const AnIntent: JIntent): JIBinder;
    procedure AndroidServiceConfigurationChanged(const Sender: TObject; const NewConfig: JConfiguration);
    procedure AndroidServiceCreate(Sender: TObject);
    procedure AndroidServiceDestroy(Sender: TObject);
    function AndroidServiceHandleMessage(const Sender: TObject; const AMessage: JMessage): Boolean;
    procedure AndroidServiceLowMemory(const Sender: TObject);
    procedure AndroidServiceRebind(const Sender: TObject; const AnIntent: JIntent);
    function AndroidServiceStartCommand(const Sender: TObject; const Intent: JIntent; Flags, StartId: Integer): Integer;
    procedure AndroidServiceTaskRemoved(const Sender: TObject; const ARootIntent: JIntent);
    procedure AndroidServiceTrimMemory(const Sender: TObject; Level: Integer);
    function AndroidServiceUnBind(const Sender: TObject; const AnIntent: JIntent): Boolean;

  private
    FThreads: TObjectList<TThread>;
    FThreadUpdate: TList<TThreadUpdate>;
    FUser: TUser;
    FHttpClient: THTTPClient;
    procedure UpdateSync(AEvent: TEvent);
    { Private declarations }
  public
    { Public declarations }
  end;

  TThreadUpdate = class(TThread)
  private
    FEvent: TEvent;
    { Private declarations }
  public
    procedure doHTTPClientAuthEvent(const Sender: TObject; AnAuthTarget: TAuthTargetType; const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean; var Persistence: TAuthPersistenceType);
    procedure Execute; override;
    property Event: TEvent read FEvent write FEvent;
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.UpdateSync(AEvent: TEvent);
var
  LThreadUpdate: TThreadUpdate;
begin
  //
  LThreadUpdate := TThreadUpdate.Create(True);
  LThreadUpdate.FreeOnTerminate := True;
  LThreadUpdate.Event := AEvent;
  FThreadUpdate.Add(LThreadUpdate);
  LThreadUpdate.Start;
end;

function TDM.AndroidServiceBind(const Sender: TObject; const AnIntent: JIntent): JIBinder;
begin
  //
end;

procedure TDM.AndroidServiceConfigurationChanged(const Sender: TObject; const NewConfig: JConfiguration);
begin
  //
end;

procedure TDM.AndroidServiceCreate(Sender: TObject);
begin
  //
  FThreads := TObjectList<TThread>.Create;
  FThreadUpdate := TList<TThreadUpdate>.Create;
  FUser := TUser.Create;
  FHttpClient := THTTPClient.Create;
end;

procedure TDM.AndroidServiceDestroy(Sender: TObject);
begin
  //
  FHttpClient.DisposeOf;
  FUser.DisposeOf;
  FThreadUpdate.DisposeOf;
  FThreads.DisposeOf;
end;

function TDM.AndroidServiceHandleMessage(const Sender: TObject; const AMessage: JMessage): Boolean;
begin
  //
end;

procedure TDM.AndroidServiceLowMemory(const Sender: TObject);
begin
  //
end;

procedure TDM.AndroidServiceRebind(const Sender: TObject; const AnIntent: JIntent);
begin
  //
end;

function TDM.AndroidServiceStartCommand(const Sender: TObject; const Intent: JIntent; Flags, StartId: Integer): Integer;
var
  LThread: TThread;
begin
  //
  LThread := TThread.CreateAnonymousThread(
    procedure
    var
      LEvent: TEvent;
    begin
      LEvent := TEvent.Create;

      UpdateSync(LEvent);
      LEvent.WaitFor(INFINITE);

      JavaService.stopSelf(StartId);
    end);

  LThread.FreeOnTerminate := True;
  FThreads.Add(LThread);
  LThread.Start;

  Result := TJService.JavaClass.START_STICKY;
end;

procedure TDM.AndroidServiceTaskRemoved(const Sender: TObject; const ARootIntent: JIntent);
begin
  //
end;

procedure TDM.AndroidServiceTrimMemory(const Sender: TObject; Level: Integer);
begin
  //
end;

function TDM.AndroidServiceUnBind(const Sender: TObject; const AnIntent: JIntent): Boolean;
begin
  //
end;

procedure TThreadUpdate.doHTTPClientAuthEvent(const Sender: TObject; AnAuthTarget: TAuthTargetType; const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean; var Persistence: TAuthPersistenceType);
var
  MyCredential: TCredentialsStorage.TCredential;
begin
  MyCredential := FHttpClient.CredentialsStorage.FindAccurateCredential(AnAuthTarget, '');
  AUserName := MyCredential.UserName;
  APassword := MyCredential.Password;
end;

procedure TThreadUpdate.Execute;
var
  LTime: Integer;
  LContent: string;

  LFile: string;
  LST: TStringStream;

const
  cID = '"id":';
begin
  //
  FHttpClient := THTTPClient.Create;
  FHttpClient.Get(cAPI + cAPI_PositionLast);
  FHttpClient.CustHeaders.Clear;
  FHttpClient.CustHeaders.Add('Content-Type', cAppJson);
  FHttpClient.

     LTime := 1;

  LFile := TPath.Combine(TPath.GetSharedDocumentsPath, 'ServicePositionLast' + FormatDateTime('yyyymmdd-hhnnss', Now) + '.json');
  LST := TStringStream.Create(EmptyStr, TEncoding.UTF8);

  while not Terminated do
  begin
    Inc(LTime);

    RESTRequest.ExecuteAsync(
      procedure
      begin
        LContent := RESTResponse.Content;
      end, True, True,
      procedure(AObject: TObject)
      begin
        LContent := ('Error: ' + ERESTException(AObject).Message);
      end);

    LST.WriteString(LContent);
    LST.SaveToFile(LFile);

    Sleep(1000);

    if (LTime > 5) then
    begin
      FEvent.SetEvent;
      Terminate;
    end;
  end;

  LST.DisposeOf;
end;

end.
