unit uFrmMain;

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
  FMX.ActnList,
  FMX.Ani,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.DialogService,
  FMX.Edit,
  FMX.Forms,
  FMX.Gestures,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.ListBox,
  FMX.ListView,
  FMX.ListView.Adapters.Base,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.Media,
  FMX.MediaLibrary.Actions,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.MultiView,
  FMX.Objects,
  FMX.Platform,
  FMX.ScrollBox,
  FMX.StdActns,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  {$IFDEF ANDROID}
  AndroidApi.Helpers,
  AndroidApi.JNI.App,
  AndroidApi.JNI.GraphicsContentViewText,
  AndroidApi.JNI.JavaTypes,
  AndroidApi.JNI.Net,
  AndroidApi.JNI.Os,
  AndroidApi.JNI.Provider,
  AndroidApi.JNI.Telephony,
  AndroidApi.JNIBridge,
  FMX.Maps.Android,
  FMX.Platform.Android,
  System.Android.Service,
  {$ENDIF}
  // IdBaseComponent,
  // IdComponent,
  // IdIOHandler,
  // IdIOHandlerSocket,
  // IdIOHandlerStack,
  // IdSSL,
  // IdSSLOpenSSL,
  // IdSSLOpenSSLHeaders,
  //
  FMX.TMSFNCCloudBase,
  FMX.TMSFNCCustomControl,
  FMX.TMSFNCGeoCoding,
  FMX.TMSFNCGoogleMaps,
  FMX.TMSFNCGooglePlaces,
  FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes,
  FMX.TMSFNCMaps,
  FMX.TMSFNCMaps.GoogleMaps,
  FMX.TMSFNCMapsCommonTypes,
  FMX.TMSFNCMapsImage,
  FMX.TMSFNCTypes,
  FMX.TMSFNCUtils,
  FMX.TMSFNCWebBrowser,
  //
  System.Actions,
  System.AnsiStrings,
  System.Classes,
  System.DateUtils,
  System.Generics.Collections,
  System.ImageList,
  System.IOUtils,
  System.Math,
  System.Permissions,
  System.Sensors,
  System.Sensors.Components,
  System.StrUtils,
  System.SysUtils,
  System.Types,
  System.UIConsts,
  System.UITypes,
  System.Variants,
  //
  uLog,
  uLoading,
  SaveStateHelper,
  uConsts,
  uLibrary,
  uUser,
  uLogin,
  uPositionLast,
  uDM;

type
  TFrmMain = class(TForm)
    actComandos: TAction;
    actConfiguracoes: TAction;
    actEventos: TAction;
    actHistoricoPosicoes: TAction;
    actListarVeiculos: TAction;
    actlMain: TActionList;
    actMostrarMapa: TAction;
    btnMenuComandos: TSpeedButton;
    btnMenuConfiguracoes: TSpeedButton;
    btnMenuEventos: TSpeedButton;
    btnMenuHistoricoPosicoes: TSpeedButton;
    btnMenuListaVeiculos: TSpeedButton;
    btnMenuMostraMapa: TSpeedButton;
    edtLoginNome: TEdit;
    edtLoginSenha: TEdit;
    grdLytMenuMapa: TGridLayout;
    ImageList128: TImageList;
    imgBtnComandos: TImage;
    imgBtnConfiguracoes: TImage;
    imgBtnEventos: TImage;
    imgBtnHistoricoPosicoes: TImage;
    imgBtnListaVeiculos: TImage;
    imgBtnListaVeiculos__: TImage;
    imgBtnMenu: TImage;
    imgBtnMostraMapa: TImage;
    imgBtnMostraMapa__: TImage;
    imglMain48: TImageList;
    imgLogo: TImage;
    imgMenuComandos: TImage;
    imgMenuConfiguracoes: TImage;
    imgMenuEventos: TImage;
    imgMenuHistoricoPosicoes: TImage;
    imgMenuListaVeiculos: TImage;
    imgMenuMostraMapa: TImage;
    imgMenuView: TImage;
    lblEntrar: TLabel;
    lblEsqueciSenha: TLabel;
    lblLoginNome: TLabel;
    lblLoginSenha: TLabel;
    lblSempreLogado: TLabel;
    lblTituloMapa: TLabel;
    lstbMenuMapa: TListBox;
    lstiBtnListaVeiculos: TListBoxItem;
    lstiBtnMostraMapa: TListBoxItem;
    lstvHistoricoPosicoes: TListView;
    lstvListaVeiculos: TListView;
    lytBtnComandos: TLayout;
    lytBtnConfiguracoes: TLayout;
    lytBtnEventos: TLayout;
    lytBtnHistoricoPosicoes: TLayout;
    lytBtnListaVeiculos: TLayout;
    lytBtnListaVeiculos__: TLayout;
    lytBtnMostraMapa: TLayout;
    lytBtnMostraMapa__: TLayout;
    lytContentLogin: TLayout;
    lytContentMapa: TLayout;
    lytEntrar: TLayout;
    lytHistoricoPosicoes: TLayout;
    lytListaVeiculos: TLayout;
    lytLogar: TLayout;
    lytLoginNome: TLayout;
    lytLoginSenha: TLayout;
    lytLogo: TLayout;
    lytMapa: TLayout;
    lytMenuComandos: TLayout;
    lytMenuConfiguracoes: TLayout;
    lytMenuEventos: TLayout;
    lytMenuHistoricoPosicoes: TLayout;
    lytMenuListaVeiculos: TLayout;
    lytMenuMostraMapa: TLayout;
    lytSempreLogado: TLayout;
    lytTituloMapa: TLayout;
    mmoDebug: TMemo;
    mvMenuView: TMultiView;
    rectBtnEntrar: TRectangle;
    rectBtnListaVeiculos: TRectangle;
    rectBtnMenu: TRectangle;
    rectBtnMostraMapa: TRectangle;
    rectMenu: TRectangle;
    rectMenuMapa: TRectangle;
    rectMenuView: TRectangle;
    rectNavMapa: TRectangle;
    swtSempreLogado: TSwitch;
    tbcMain: TTabControl;
    tbiDebug: TTabItem;
    tbiLogin: TTabItem;
    tbiMapa: TTabItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure actComandosExecute(Sender: TObject);
    procedure actConfiguracoesExecute(Sender: TObject);
    procedure actEventosExecute(Sender: TObject);
    procedure actHistoricoPosicoesExecute(Sender: TObject);
    procedure actListarVeiculosExecute(Sender: TObject);
    procedure actMostrarMapaExecute(Sender: TObject);
    procedure btnListaVeiculos2_Click(Sender: TObject);
    procedure btnMenuHistoricoPosicoesClick(Sender: TObject);
    procedure btnMenuListaVeiculosClick(Sender: TObject);
    procedure btnMenuMostraMapaClick(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
    procedure imgBtnHistoricoPosicoesClick(Sender: TObject);
    procedure imgBtnListaVeiculosClick(Sender: TObject);
    procedure imgBtnMostraMapaClick(Sender: TObject);
    procedure imgMenuListaVeiculosClick(Sender: TObject);
    procedure imgMenuMostraMapaClick(Sender: TObject);
    procedure lblEntrarClick(Sender: TObject);
    procedure lstvListaVeiculosItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure mvMenuViewStartHiding(Sender: TObject);
    procedure mvMenuViewStartShowing(Sender: TObject);
    procedure rectBtnListaVeiculosClick(Sender: TObject);
    procedure rectBtnMostraMapaClick(Sender: TObject);

  private
    FPanelMap: TPanel;
    FTimerDrawOnMap: TTimer;

    FImageCarOn48: string;
    FImageCarOff48: string;

    {$IFDEF ANDROID}
    procedure PermissionMessage(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure PermissionResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    {$ENDIF}
    procedure fazerLogin;
    procedure listarVeiculos;
    procedure historicoPosicoes;

    procedure doCustomizeHeadLinks(Sender: TObject; AList: TTMSFNCMapsLinksList);
    procedure doMapInitialized(Sender: TObject);

    procedure doUpdateDrawOnMap(Sender: TObject);

    procedure doMarkerClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    procedure doMostraMapa;
    procedure doListaVeiculos;
    procedure doHistoricoPosicoes;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  Map: TTMSFNCGoogleMaps;
  IsPositionFirst: boolean;
  StateBinaryReader: TBinaryReader;

const
  {$IFDEF ANDROID}
  PermissionInternet = 'android.permission.INTERNET';
  PermissionReadExternalStorage = 'android.permission.READ_EXTERNAL_STORAGE';
  PermissionWriteExternalStorage = 'android.permission.WRITE_EXTERNAL_STORAGE';
  {$ENDIF}
  JustificationInternet = 'O aplicativo precisa ter a permissão da Internet.';
  JustificationReadExternalStorage = 'O aplicativo precisa ler arquivos do dispositivo.';
  JustificationWriteExternalStorage = 'O aplicativo precisa escrever arquivos do dispositivo.';

  cLat = -23.5653541;
  cLng = -46.6533425;
  cZoom = 18;

implementation

{$R *.fmx}
{$IFDEF ANDROID}

procedure TFrmMain.PermissionMessage(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
var
  LCount: Integer;
  LMsg: string;
begin
  LMsg := EmptyStr;

  for LCount := Low(APermissions) to High(APermissions) do
  begin
    if APermissions[LCount] = PermissionInternet then
    begin
      LMsg := LMsg + JustificationInternet + sLineBreak;
    end
    else if APermissions[LCount] = PermissionReadExternalStorage then
    begin
      LMsg := LMsg + JustificationReadExternalStorage + sLineBreak;
    end
    else if APermissions[LCount] = PermissionWriteExternalStorage then
    begin
      LMsg := LMsg + JustificationWriteExternalStorage + sLineBreak;
    end;
  end;

  TDialogService.ShowMessage(LMsg,
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end);
end;
{$ENDIF}
{$IFDEF ANDROID}

procedure TFrmMain.PermissionResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
var
  LCount: Integer;
begin
  for LCount := Low(APermissions) to High(APermissions) do
  begin
    {$REGION 'PermissionInternet'}
    if APermissions[LCount] = PermissionInternet then
    begin
      if (AGrantResults[LCount] = TPermissionStatus.Granted) then
      begin

      end
      else if (AGrantResults[LCount] = TPermissionStatus.Denied) then
      begin

      end
      else if (AGrantResults[LCount] = TPermissionStatus.PermanentlyDenied) then
      begin

      end;
    end;
    {$ENDREGION}
    {$REGION 'PermissionReadExternalStorage'}
    if APermissions[LCount] = PermissionReadExternalStorage then
    begin
      if (AGrantResults[LCount] = TPermissionStatus.Granted) then
      begin
        // lstbiReadFile.ItemData.Detail := 'Liberado o acesso para Leitura de Arquivos.';
        // swtReadFile.IsChecked := True;
        // swtReadFile.Enabled := False;
      end
      else if (AGrantResults[LCount] = TPermissionStatus.Denied) then
      begin
        // lstbiReadFile.ItemData.Detail := 'Acesso para Leitura de Arquivos, não liberado.';
        // swtReadFile.Enabled := True;
      end
      else if (AGrantResults[LCount] = TPermissionStatus.PermanentlyDenied) then
      begin
        // lstbiReadFile.ItemData.Detail := 'Acesso para Leitura de Arquivos, não liberado permanentemente.';
        // swtReadFile.Enabled := True;
      end;
    end;
    {$ENDREGION}
    {$REGION 'PermissionWriteExternalStorage'}
    if APermissions[LCount] = PermissionWriteExternalStorage then
    begin
      if (AGrantResults[LCount] = TPermissionStatus.Granted) then
      begin
        // lstbiWriteFile.ItemData.Detail := 'Liberado o acesso para Escrita de Arquivos.';
        // swtWriteFile.IsChecked := True;
        // swtWriteFile.Enabled := False;
      end
      else if (AGrantResults[LCount] = TPermissionStatus.Denied) then
      begin
        // lstbiWriteFile.ItemData.Detail := 'Acesso para Escrita de Arquivos, não liberado.';
        // swtWriteFile.Enabled := True;
      end
      else if (AGrantResults[LCount] = TPermissionStatus.PermanentlyDenied) then
      begin
        // lstbiWriteFile.ItemData.Detail := 'Acesso para Escrita de Arquivos, não liberado permanentemente.';
        // swtWriteFile.Enabled := True;
      end;
    end;
    {$ENDREGION}
  end;
end;
{$ENDIF}

procedure TFrmMain.fazerLogin;
var
  LUsername: string;
  LPassword: string;
  LError: string;
  LLogged: boolean;
begin
  LLogged := False;
  LError := EmptyStr;

  LUsername := Trim(edtLoginNome.Text);
  LPassword := Trim(edtLoginSenha.Text);

  if (LUsername = EmptyStr) then
  begin
    TDialogService.ShowMessage(cMSG_CAMPO_VAZIO + sLineBreak + //
       'Favor preencher o login.');
    edtLoginNome.SetFocus;
    Exit;
  end;

  if (LPassword = EmptyStr) then
  begin
    TDialogService.ShowMessage(cMSG_CAMPO_VAZIO + sLineBreak + //
       'Favor preencher a senha.');
    edtLoginSenha.SetFocus;
    Exit;
  end;

  LLogged := Login.doLogin(LUsername, LPassword, EmptyStr, LError);

  if LLogged then
  begin
    tbcMain.ActiveTab := tbiMapa;

    PositionLast.Timer.Enabled := True;
    FTimerDrawOnMap.Enabled := True;

    Toast(User.Name + ', login realizado com sucesso!', 3);
  end
  else if not(LError = EmptyStr) then
  begin
    TDialogService.ShowMessage(cMSG_SUPORTE + sLineBreak + LError);
    Exit;
  end
  else
  begin
    TDialogService.ShowMessage(cMSG_SUPORTE);
    Exit;
  end;
end;

procedure TFrmMain.doCustomizeHeadLinks(Sender: TObject; AList: TTMSFNCMapsLinksList);
begin
  AList.Clear;
  AList.Add(TTMSFNCMapsLink.CreateScript( //
     'https://maps.googleapis.com/maps/api/js?key=' + Map.APIKey + //
     '&libraries=places&language=' + Map.Options.Locale, 'text/javascript', 'utf-8', EmptyStr, True, True));
end;

procedure TFrmMain.doMapInitialized(Sender: TObject);
begin
  Map.BeginUpdate;

  Map.ExecuteJavaScript('initAutoComplete();');
  Map.ExecuteJavaScript('new AutocompleteDirectionsHandler(map);');

  Map.Options.ShowTraffic := False;
  Map.Options.ShowBicycling := False;
  Map.Options.ShowStreetViewControl := False;
  Map.Options.ShowMapTypeControl := False;

  Map.Options.ShowScaleControl := True;
  Map.Options.ShowZoomControl := True;

  Map.Options.MapTypeID := gmtDefault;
  Map.Options.StreetView.Enabled := False;
  Map.Options.Console := False;

  Map.Options.ZoomOnDblClick := True;
  Map.Options.ZoomOnWheelScroll := True;

  Map.SetCenterCoordinate(cLat, cLng);
  Map.SetZoomLevel(cZoom);

  Map.EndUpdate;
end;

procedure TFrmMain.doMarkerClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
begin
  Map.ShowPopup( //
     AEventData.Coordinate.Latitude //
     , AEventData.Coordinate.Longitude //
     , AEventData.Marker.DataString //
     , 24 //
     , -42);
end;

procedure TFrmMain.doMostraMapa;
begin
  if mvMenuView.Visible then
  begin
    mvMenuView.HideMaster;
    mvMenuView.Visible := False;
  end;

  Map.Visible := True;
  lytMapa.Visible := True;
  lytMapa.BringToFront;

  lytListaVeiculos.SendToBack;
  lytListaVeiculos.Visible := False;
end;

procedure TFrmMain.doListaVeiculos;
begin
  if mvMenuView.Visible then
  begin
    mvMenuView.HideMaster;
    mvMenuView.Visible := False;
  end;

  Map.Visible := False;
  lytMapa.Visible := False;
  lytMapa.SendToBack;

  lytListaVeiculos.BringToFront;
  lytListaVeiculos.Visible := True;

  TThread.Queue(nil,
    procedure
    begin
      listarVeiculos;
    end);
end;

procedure TFrmMain.doHistoricoPosicoes;
begin
  TLoading.Show(FrmMain, 'Consultando Histórico de Posições...');

  TThread.Queue(nil,
    procedure
    begin
      if mvMenuView.Visible then
      begin
        mvMenuView.HideMaster;
        mvMenuView.Visible := False;
      end;

      Map.Visible := False;
      lytMapa.Visible := False;
      lytMapa.SendToBack;

      lytHistoricoPosicoes.BringToFront;
      lytHistoricoPosicoes.Visible := True;

      historicoPosicoes;

      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
        end);

    end);
end;

procedure TFrmMain.doUpdateDrawOnMap(Sender: TObject);
var
  FQry: TFDQuery;
  LSQL: string;

  bExists: boolean;
  iTotal: Integer;

  LCaracter: Integer;

  LMarker: TTMSFNCGoogleMapsMarker;
  LOverlayView: TTMSFNCGoogleMapsOverlayView;

  LContent: string;

  LTerminalId: string;
  LEquipmentBrandName: string;
  LEquipmentModelName: string;

  LCustomerId: Integer;
  LCustomerName: string;
  LPlate: string;
  LVehicleBrandName: string;
  LVehicleModelName: string;
  LVehicleColorId: Integer;
  LVehicleColor: string;

  LEventDate: TDateTime;
  LSatellites: Integer;
  LLatitude: double;
  LLongitude: double;
  LCourse: Integer;
  LAddress: string;

  LIgnitionStatus: boolean;
  LIgnitionStatus_: string;
  LSpeed: Integer;
  LOdometer: Integer;
  LHorimeter: Integer;
  LPowerVoltage: double;
  LCharge: boolean;
  LCharge_: string;
  LBatteryVoltage: Integer;
  LGsmSignalStrength: Integer;
  LAlarms: string;

  LTitle: string;
  LData: string;

const
  cCaracter = 80;

begin
  TThread.Queue(nil,
    procedure
    begin
      FTimerDrawOnMap.Enabled := False;
      try
        TThread.Synchronize(nil,
          procedure
          begin
            {$REGION 'Synchronize'}
            LSQL := //
               'SELECT *' + sLineBreak + //
               'FROM POSITIONS_LAST' + sLineBreak + //
               'WHERE 1 = 1' + sLineBreak + //
               'AND ID_USER = ' + IntToStr(User.Id) + sLineBreak + //
               'ORDER BY ID_POSITION_LAST DESC';

            {$IFDEF DEBUG}
            // LogApp('DEBUG', EmptyStr, LSQL);
            {$ENDIF}
            FQry := TFDQuery.Create(nil);
            try
              FQry.Connection := DM.FDConn;

              try
                FQry.Open(LSQL);

                {$REGION 'Carregar Veiculos'}
                if not FQry.IsEmpty then
                begin
                  bExists := not FQry.IsEmpty;
                  iTotal := FQry.RecordCount;

                  if not bExists then
                  begin
                    Logg.LogApp('APP: Nao foi possivel carregar os veiculos', EmptyStr);
                    Exit;
                  end;

                  if (iTotal = 0) then
                  begin
                    Logg.LogApp('APP: Sem veiculos para carregar no mapa', EmptyStr);
                    Exit;
                  end;

                  // Map.Clear;
                  // Map.ClearCache;
                  // Map.ClearHeadLinks;
                  // Map.ClearMarkers;
                  // Map.ClearElementContainers;
                  // Map.ClearOverlayViews;
                  // Map.ClearPolylines;
                  // Map.ClearPolygons;
                  // Map.ClearCircles;
                  // Map.ClearRectangles;
                  // Map.CloseAllPopups;

                  Map.Markers.Clear;
                  Map.OverlayViews.Clear;

                  FQry.First;

                  while not FQry.Eof do
                  begin
                    {$REGION 'Carregar Vriaveis'}
                    //
                    LTerminalId := FQry.FindField('TERMINAL_ID').AsString;
                    LEquipmentBrandName := FQry.FindField('EQUIPMENT_BRAND_NAME').AsString;
                    LEquipmentModelName := FQry.FindField('EQUIPMENT_MODEL_NAME').AsString;

                    LCustomerId := FQry.FindField('CUSTOMER_ID').AsInteger;
                    LCustomerName := FQry.FindField('CUSTOMER_NAME').AsString;
                    LPlate := FQry.FindField('PLATE').AsString;
                    LVehicleBrandName := FQry.FindField('VEHICLE_BRAND_NAME').AsString;
                    LVehicleModelName := Copy(FQry.FindField('VEHICLE_MODEL_NAME').AsString, 1, 15);
                    LVehicleColorId := FQry.FindField('VEHICLE_COLOR_ID').AsInteger;
                    LVehicleColor := FQry.FindField('VEHICLE_COLOR').AsString;

                    LEventDate := FQry.FindField('EVENT_DATE').AsDateTime;
                    LSatellites := FQry.FindField('SATELLITES').AsInteger;
                    LLatitude := FQry.FindField('LATITUDE').AsFloat;
                    LLongitude := FQry.FindField('LONGITUDE').AsFloat;
                    LCourse := FQry.FindField('COURSE').AsInteger;
                    LAddress := FQry.FindField('ADDRESS').AsString;

                    LIgnitionStatus := FQry.FindField('IGNITION_STATUS').AsBoolean;

                    if LIgnitionStatus then
                    begin
                      LIgnitionStatus_ := cIgnitionOnText;
                    end
                    else
                    begin
                      LIgnitionStatus_ := cIgnitionOffText;
                    end;

                    LSpeed := FQry.FindField('SPEED').AsInteger;
                    LOdometer := FQry.FindField('ODOMETER').AsInteger;
                    LHorimeter := FQry.FindField('HORIMETER').AsInteger;
                    LPowerVoltage := FQry.FindField('POWER_VOLTAGE').AsFloat;

                    LCharge := FQry.FindField('CHARGE').AsBoolean;

                    if LCharge then
                    begin
                      // LCharge_ := cBatteryOnText;
                      LCharge_ := LPowerVoltage.ToString;
                    end
                    else
                    begin
                      // LCharge_ := cBatteryOffText;
                      LCharge_ := '0';
                    end;

                    LBatteryVoltage := FQry.FindField('BATTERY_VOLTAGE').AsInteger;
                    LGsmSignalStrength := FQry.FindField('GSM_SIGNAL_STRENGTH').AsInteger;
                    LAlarms := FQry.FindField('ALARMS').AsString;

                    {$REGION 'Verifica os Dados'}
                    if (LTerminalId = EmptyStr) then
                      LTerminalId := 'N/D';

                    if (LEquipmentBrandName = EmptyStr) then
                      LEquipmentBrandName := 'N/D';

                    if (LEquipmentModelName = EmptyStr) then
                      LEquipmentModelName := 'N/D';

                    // if ( LCustomerId: Integer;  LCustomerId := 'N/D';

                    if (LCustomerName = EmptyStr) then
                      LCustomerName := 'N/D';

                    if (LPlate = EmptyStr) then
                      LPlate := 'Novo';

                    if (LVehicleBrandName = EmptyStr) then
                      LVehicleBrandName := 'N/D';

                    if (LVehicleModelName = EmptyStr) then
                      LVehicleModelName := 'N/D';

                    // if ( LVehicleColorId: Integer;  LVehicleColorId := 'N/D';
                    // if ( LVehicleColor = EmptyStr ) then  LVehicleColor := 'N/D';
                    //
                    // if ( LEventDate: TDateTime;  LEventDate := 'N/D';
                    // if ( LSatellites: Integer;  LSatellites := 'N/D';
                    // if ( LLatitude: double;  LLatitude := 'N/D';
                    // if ( LLongitude: double;  LLongitude := 'N/D';
                    // if ( LCourse: Integer;  LCourse := 'N/D';
                    // if ( LAddress = EmptyStr ) then  LAddress := 'N/D';
                    //
                    // if ( LIgnitionStatus: Boolean;  LIgnitionStatus := 'N/D';
                    // if ( LIgnitionStatus_ = EmptyStr ) then  LIgnitionStatus_ := 'N/D';
                    // if ( LSpeed: Integer;  LSpeed := 'N/D';
                    // if ( LOdometer: Integer;  LOdometer := 'N/D';
                    // if ( LHorimeter: Integer;  LHorimeter := 'N/D';
                    // if ( LPowerVoltage: double;  LPowerVoltage := 'N/D';
                    // if ( LCharge: Boolean;  LCharge := 'N/D';
                    // if ( LCharge_ = EmptyStr ) then  LCharge_ := 'N/D';
                    // if ( LBatteryVoltage: Integer;  LBatteryVoltage := 'N/D';
                    // if ( LGsmSignalStrength: Integer;  LGsmSignalStrength := 'N/D';
                    // if ( LAlarms = EmptyStr ) then  LAlarms := 'N/D';
                    {$ENDREGION}
                    //

                    LTitle := //
                       RosaDosVentos(LCourse, True) + ' ' + LPlate;

                    LData := //
                       '<br><b>Placa: </b>' + LPlate + sLineBreak + //
                       '<br><b>Associado: </b>' + LCustomerName + sLineBreak + //
                       '<br><b>Marca Veíc.: </b>' + LVehicleBrandName + sLineBreak + //
                       '<br><b>Modelo Veíc.: </b>' + LVehicleModelName + sLineBreak + //
                    // '<br><b>Status Ignição: </b> 🔑 ' + LIgnitionStatus_ + sLineBreak + //
                       '<br><b>Status Bateria: </b> 🔋 ' + LCharge_ + sLineBreak + //
                       '<br><b>Últ. Posição: </b> ⏱ ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LEventDate) + sLineBreak + //
                    // '<br><b>Direção: </b>' + RosaDosVentos(LCourse) + sLineBreak + //
                       '<br><b>Odometro: </b>' + IntToStr(LOdometer) + sLineBreak + //
                       '<br><b>Horimetro: </b>' + IntToStr(LHorimeter) + sLineBreak + //
                       '<br><b>Localização: </b>' + LAddress + sLineBreak + //
                       '';

                    { todo -o@WOS83:Posição Atual no Mapa }
                    Map.BeginUpdate;

                    {$REGION 'Markers'}
                    LMarker := Map.Markers.Add;

                    {$IFDEF MSWINDOWS}
                    if LIgnitionStatus then
                    begin
                      LMarker.IconURL := FImageCarOn48;
                      // LMarker.Cluster.ImagePath := FImageCarOn48;
                    end
                    else
                    begin
                      LMarker.IconURL := FImageCarOff48;
                      // LMarker.Cluster.ImagePath := FImageCarOff48;
                    end;
                    {$ENDIF}
                    {$IFDEF ANDROID}
                    if LIgnitionStatus then
                    begin
                      LMarker.IconURL := FImageCarOn48;
                    end
                    else
                    begin
                      LMarker.IconURL := FImageCarOff48;
                    end;
                    {$ENDIF}
                    LMarker.Latitude := LLatitude;
                    LMarker.Longitude := LLongitude;

                    LMarker.Clickable := True;

                    LMarker.Title := LTitle;
                    LMarker.DisplayName := LTitle;
                    LMarker.DataString := LData;

                    LMarker.Visible := True;
                    {$ENDREGION}
                    //
                    {$REGION 'OverlayView'}
                    LOverlayView := Map.AddOverlayView;
                    LOverlayView.Clickable := False;

                    LOverlayView.Mode := omCoordinate;
                    LOverlayView.Coordinate.Latitude := LLatitude;
                    LOverlayView.Coordinate.Longitude := LLongitude;

                    LOverlayView.CoordinatePosition := cpTopCenter;
                    LOverlayView.CoordinateOffsetTop := Trunc(LMarker.IconHeight * -1) + 14;
                    LOverlayView.CoordinateOffsetLeft := Trunc(LMarker.IconWidth) + 8;

                    LOverlayView.Text := LTitle;
                    LOverlayView.DataString := LData;

                    LOverlayView.Font.Size := 11;
                    LOverlayView.BorderColor := 0;

                    if LIgnitionStatus then
                    begin
                      LOverlayView.Font.Color := TAlphaColorRec.White;
                      LOverlayView.BackgroundColor := cIgnitionColor;
                    end
                    else
                    begin
                      LOverlayView.Font.Color := TAlphaColorRec.White;
                      LOverlayView.BackgroundColor := cIgnitionColor;
                    end;

                    LOverlayView.Visible := True;

                    {$ENDREGION}
                    Map.EndUpdate;
                    //
                    {$ENDREGION}
                    { todo -o@WOS83:Primeira Posição no Mapa }
                    if IsPositionFirst then
                    begin
                      Map.SetCenterCoordinate(LLatitude, LLongitude);
                      IsPositionFirst := False;
                    end;

                    FQry.Next;
                  end;
                end;
                {$ENDREGION}
              except
                on E: Exception do
                begin
                  Logg.LogAppSQL( //
                     'TFrmMain.carregarVeiculos' //
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
            {$ENDREGION}
          end);
      finally
        FTimerDrawOnMap.Interval := 60000;
        FTimerDrawOnMap.Enabled := True;
      end;
    end);
end;

procedure TFrmMain.listarVeiculos;
var
  FQry: TFDQuery;
  LSQL: string;

  LItem: TListViewItem;
  LImage: TListItemImage;
  LText: TListItemText;

  LBitmap: TBitmap;
  LStream: TMemoryStream;

  bExists: boolean;
  iTotal: Integer;

  LCaracter: Integer;

  LMarker: TTMSFNCGoogleMapsMarker;

  LContent: string;

  LTerminalId: string;
  LEquipmentBrandName: string;
  LEquipmentModelName: string;

  LCustomerId: Integer;
  LCustomerName: string;
  LPlate: string;
  LVehicleBrandName: string;
  LVehicleModelName: string;
  LVehicleColorId: Integer;
  LVehicleColor: string;

  LEventDate: TDateTime;
  LSatellites: Integer;
  LLatitude: double;
  LLongitude: double;
  LCourse: Integer;
  LAddress: string;

  LIgnitionStatus: boolean;
  LIgnitionStatus_: string;
  LSpeed: Integer;
  LOdometer: Integer;
  LHorimeter: Integer;
  LPowerVoltage: double;
  LCharge: boolean;
  LCharge_: string;
  LBatteryVoltage: Integer;
  LGsmSignalStrength: Integer;
  LAlarms: string;

  LTitle: string;
  LData: string;

const
  cCaracter = 80;
begin
  LSQL := //
     'SELECT *' + sLineBreak + //
     'FROM POSITIONS_LAST' + sLineBreak + //
     'WHERE 1 = 1' + sLineBreak + //
     'AND ID_USER = ' + IntToStr(User.Id) + sLineBreak + //
     'ORDER BY PLATE';

  {$IFDEF DEBUG}
  // LogApp('DEBUG', EmptyStr, LSQL);
  {$ENDIF}
  FQry := TFDQuery.Create(nil);
  try
    FQry.Connection := DM.FDConn;

    try
      FQry.Open(LSQL);

      {$REGION 'Carregar Veiculos'}
      if not FQry.IsEmpty then
      begin
        bExists := not FQry.IsEmpty;
        iTotal := FQry.RecordCount;

        if not bExists then
        begin
          Logg.LogApp('APP: Nao foi possivel carregar os veiculos', EmptyStr);
          Exit;
        end;

        if (iTotal = 0) then
        begin
          Logg.LogApp('APP: Sem veiculos para carregar no mapa', EmptyStr);
          Exit;
        end;

        lstvListaVeiculos.AllowSelection := True;
        lstvListaVeiculos.AlternatingColors := True;
        lstvListaVeiculos.AutoTapScroll := True;

        lstvListaVeiculos.CanSwipeDelete := False;
        lstvListaVeiculos.DeleteButtonText := EmptyStr;

        lstvListaVeiculos.SearchVisible := True;
        lstvListaVeiculos.SearchAlwaysOnTop := True;
        lstvListaVeiculos.SelectionCrossfade := False;

        lstvListaVeiculos.ItemAppearance.ItemHeight := 66;

        lstvListaVeiculos.Items.Clear;

        while not FQry.Eof do
        begin
          {$REGION 'Carregar Variaveis'}
          //
          LTerminalId := FQry.FindField('TERMINAL_ID').AsString;
          LEquipmentBrandName := FQry.FindField('EQUIPMENT_BRAND_NAME').AsString;
          LEquipmentModelName := FQry.FindField('EQUIPMENT_MODEL_NAME').AsString;

          LCustomerId := FQry.FindField('CUSTOMER_ID').AsInteger;
          LCustomerName := FQry.FindField('CUSTOMER_NAME').AsString;
          LPlate := FQry.FindField('PLATE').AsString;
          LVehicleBrandName := FQry.FindField('VEHICLE_BRAND_NAME').AsString;
          LVehicleModelName := FQry.FindField('VEHICLE_MODEL_NAME').AsString;
          LVehicleColorId := FQry.FindField('VEHICLE_COLOR_ID').AsInteger;
          LVehicleColor := FQry.FindField('VEHICLE_COLOR').AsString;

          LEventDate := FQry.FindField('EVENT_DATE').AsDateTime;
          LSatellites := FQry.FindField('SATELLITES').AsInteger;
          LLatitude := FQry.FindField('LATITUDE').AsFloat;
          LLongitude := FQry.FindField('LONGITUDE').AsFloat;
          LCourse := FQry.FindField('COURSE').AsInteger;
          LAddress := FQry.FindField('ADDRESS').AsString;

          LIgnitionStatus := FQry.FindField('IGNITION_STATUS').AsBoolean;

          if LIgnitionStatus then
          begin
            LIgnitionStatus_ := cIgnitionOnText;
          end
          else
          begin
            LIgnitionStatus_ := cIgnitionOffText;
          end;

          LSpeed := FQry.FindField('SPEED').AsInteger;
          LOdometer := FQry.FindField('ODOMETER').AsInteger;
          LHorimeter := FQry.FindField('HORIMETER').AsInteger;
          LPowerVoltage := FQry.FindField('POWER_VOLTAGE').AsFloat;

          LCharge := FQry.FindField('CHARGE').AsBoolean;

          if LCharge then
          begin
            // LCharge_ := cBatteryOnText;
            LCharge_ := LPowerVoltage.ToString;
          end
          else
          begin
            // LCharge_ := cBatteryOffText;
            LCharge_ := '0';
          end;

          LBatteryVoltage := FQry.FindField('BATTERY_VOLTAGE').AsInteger;
          LGsmSignalStrength := FQry.FindField('GSM_SIGNAL_STRENGTH').AsInteger;
          LAlarms := FQry.FindField('ALARMS').AsString;

          {$REGION 'Verifica os Dados'}
          if (LTerminalId = EmptyStr) then
            LTerminalId := 'N/D';

          if (LEquipmentBrandName = EmptyStr) then
            LEquipmentBrandName := 'N/D';

          if (LEquipmentModelName = EmptyStr) then
            LEquipmentModelName := 'N/D';

          // if ( LCustomerId: Integer;  LCustomerId := 'N/D';

          if (LCustomerName = EmptyStr) then
            LCustomerName := 'N/D';

          if (LPlate = EmptyStr) then
            LPlate := 'Novo';

          if (LVehicleBrandName = EmptyStr) then
            LVehicleBrandName := 'N/D';

          if (LVehicleModelName = EmptyStr) then
            LVehicleModelName := 'N/D';

          // if ( LVehicleColorId: Integer;  LVehicleColorId := 'N/D';
          // if ( LVehicleColor = EmptyStr ) then  LVehicleColor := 'N/D';
          //
          // if ( LEventDate: TDateTime;  LEventDate := 'N/D';
          // if ( LSatellites: Integer;  LSatellites := 'N/D';
          // if ( LLatitude: double;  LLatitude := 'N/D';
          // if ( LLongitude: double;  LLongitude := 'N/D';
          // if ( LCourse: Integer;  LCourse := 'N/D';
          // if ( LAddress = EmptyStr ) then  LAddress := 'N/D';
          //
          // if ( LIgnitionStatus: Boolean;  LIgnitionStatus := 'N/D';
          // if ( LIgnitionStatus_ = EmptyStr ) then  LIgnitionStatus_ := 'N/D';
          // if ( LSpeed: Integer;  LSpeed := 'N/D';
          // if ( LOdometer: Integer;  LOdometer := 'N/D';
          // if ( LHorimeter: Integer;  LHorimeter := 'N/D';
          // if ( LPowerVoltage: double;  LPowerVoltage := 'N/D';
          // if ( LCharge: Boolean;  LCharge := 'N/D';
          // if ( LCharge_ = EmptyStr ) then  LCharge_ := 'N/D';
          // if ( LBatteryVoltage: Integer;  LBatteryVoltage := 'N/D';
          // if ( LGsmSignalStrength: Integer;  LGsmSignalStrength := 'N/D';
          // if ( LAlarms = EmptyStr ) then  LAlarms := 'N/D';
          {$ENDREGION}
          //

          LTitle := //
             RosaDosVentos(LCourse, True) + ' ' + LPlate + //
             ''; // sLineBreak + LIgnitionStatus_;

          LData := //
             '<br><b>Placa: </b>' + LPlate + sLineBreak + //
             '<br><b>Associado: </b>' + LCustomerName + sLineBreak + //
             '<br><b>Marca Veíc.: </b>' + LVehicleBrandName + sLineBreak + //
             '<br><b>Modelo Veíc.: </b>' + LVehicleModelName + sLineBreak + //
          // '<br><b>Status Ignição: </b> 🔑 ' + LIgnitionStatus_ + sLineBreak + //
             '<br><b>Status Bateria: </b> 🔋 ' + LCharge_ + sLineBreak + //
             '<br><b>Últ. Posição: </b> ⏱ ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LEventDate) + sLineBreak + //
          // '<br><b>Direção: </b>' + RosaDosVentos(LCourse) + sLineBreak + //
             '<br><b>Odometro: </b>' + IntToStr(LOdometer) + sLineBreak + //
             '<br><b>Horimetro: </b>' + IntToStr(LHorimeter) + sLineBreak + //
             '';

          LItem := lstvListaVeiculos.Items.Add;

          with LItem do
          begin
            TagString := LTerminalId;

            LItem.Data['TERMINAL_ID'] := LTerminalId;
            LItem.Data['EQUIPMENT_BRAND_NAME'] := LEquipmentBrandName;
            LItem.Data['EQUIPMENT_MODEL_NAME'] := LEquipmentModelName;
            LItem.Data['CUSTOMER_ID'] := LCustomerId;
            LItem.Data['CUSTOMER_NAME'] := LCustomerName;
            LItem.Data['PLATE'] := LPlate;
            LItem.Data['VEHICLE_BRAND_NAME'] := LVehicleBrandName;
            LItem.Data['VEHICLE_MODEL_NAME'] := LVehicleModelName;
            LItem.Data['VEHICLE_COLOR_ID'] := LVehicleColorId;
            LItem.Data['VEHICLE_COLOR'] := LVehicleColor;
            LItem.Data['EVENT_DATE'] := LEventDate;
            LItem.Data['SATELLITES'] := LSatellites;
            LItem.Data['LATITUDE'] := LLatitude;
            LItem.Data['LONGITUDE'] := LLongitude;
            LItem.Data['COURSE'] := LCourse;
            LItem.Data['ADDRESS'] := LAddress;
            LItem.Data['IGNITION_STATUS'] := LIgnitionStatus;
            LItem.Data['SPEED'] := LSpeed;
            LItem.Data['ODOMETER'] := LOdometer;
            LItem.Data['HORIMETER'] := LHorimeter;
            LItem.Data['POWER_VOLTAGE'] := LPowerVoltage;
            LItem.Data['CHARGE'] := LCharge;
            LItem.Data['BATTERY_VOLTAGE'] := LBatteryVoltage;
            LItem.Data['GSM_SIGNAL_STRENGTH'] := LGsmSignalStrength;
            LItem.Data['ALARMS'] := LAlarms;

            if not(LBitmap = nil) then
              LBitmap := nil;

            LBitmap := TBitmap.Create;

            // {$IFDEF MSWINDOWS}
            if LIgnitionStatus then
            begin
              BitmapFromBase64(cImageBase64CarOn48, LBitmap);
              TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap := LBitmap;
              TListItemText(Objects.FindDrawable('lblEvent1')).TextColor := cIgnitionOnColor;
            end
            else
            begin
              BitmapFromBase64(cImageBase64CarOff48, LBitmap);
              TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap := LBitmap;
              TListItemText(Objects.FindDrawable('lblEvent1')).TextColor := cIgnitionOffColor;
            end;

            if LCharge then
            begin
              TListItemText(Objects.FindDrawable('lblEvent2')).TextColor := cBatteryOnColor;
            end
            else
            begin
              TListItemText(Objects.FindDrawable('lblEvent2')).TextColor := cBatteryOffColor;
            end;

            // {$ENDIF}
            // {$IFDEF ANDROID}
            // if LIgnitionStatus then
            // begin
            // TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap.LoadFromURL(cImageBase64CarOn48);
            // end
            // else
            // begin
            // TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap.LoadFromURL(cImageBase64CarOff48);
            // end;
            // {$ENDIF}

            TListItemText(Objects.FindDrawable('lblVeiculo')).Text := LPlate;
            TListItemText(Objects.FindDrawable('lblVeiculo')).Font.Size := 10;
            TListItemText(Objects.FindDrawable('lblVeiculo')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblDescricao')).Text := LCustomerName;
            TListItemText(Objects.FindDrawable('lblDescricao')).Font.Size := 9;
            TListItemText(Objects.FindDrawable('lblDescricao')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblEvent1')).Text := '🔑 ' + LIgnitionStatus_;
            TListItemText(Objects.FindDrawable('lblEvent1')).Font.Size := 9;
            TListItemText(Objects.FindDrawable('lblEvent1')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblEvent2')).Text := '🔋 ' + LCharge_;
            TListItemText(Objects.FindDrawable('lblEvent2')).Font.Size := 9;
            TListItemText(Objects.FindDrawable('lblEvent2')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblEvent3')).Text := LSpeed.ToString + ' km/h';
            TListItemText(Objects.FindDrawable('lblEvent3')).Font.Size := 9;
            TListItemText(Objects.FindDrawable('lblEvent3')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblEvent4')).Text := '⏱ ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LEventDate);
            TListItemText(Objects.FindDrawable('lblEvent4')).Font.Size := 9;
            TListItemText(Objects.FindDrawable('lblEvent4')).TextAlign := TTextAlign.Leading;
            TListItemText(Objects.FindDrawable('lblEvent4')).Width := 120;
          end;

          {$ENDREGION}
          FQry.Next;
        end;
      end;
      {$ENDREGION}
    except
      on E: Exception do
      begin
        Logg.LogAppSQL( //
           'TFrmMain.carregarVeiculos' //
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

procedure TFrmMain.historicoPosicoes;
var
  FQry: TFDQuery;
  LSQL: string;

  LItem: TListViewItem;
  LImage: TListItemImage;
  LText: TListItemText;

  LBitmap: TBitmap;
  LStream: TMemoryStream;

  bExists: boolean;
  iTotal: Integer;

  LCaracter: Integer;

  LMarker: TTMSFNCGoogleMapsMarker;

  LContent: string;

  LTerminalId: string;
  LEquipmentBrandName: string;
  LEquipmentModelName: string;

  LCustomerId: Integer;
  LCustomerName: string;
  LPlate: string;
  LVehicleBrandName: string;
  LVehicleModelName: string;
  LVehicleColorId: Integer;
  LVehicleColor: string;

  LEventDate: TDateTime;
  LSatellites: Integer;
  LLatitude: double;
  LLongitude: double;
  LCourse: Integer;
  LAddress: string;

  LIgnitionStatus: boolean;
  LIgnitionStatus_: string;
  LSpeed: Integer;
  LOdometer: Integer;
  LHorimeter: Integer;
  LPowerVoltage: double;
  LCharge: boolean;
  LCharge_: string;
  LBatteryVoltage: Integer;
  LGsmSignalStrength: Integer;
  LAlarms: string;

  LTitle: string;
  LData: string;

const
  cCaracter = 80;
begin
  LSQL := //
     'SELECT *' + sLineBreak + //
     'FROM POSITIONS_HISTORY' + sLineBreak + //
     'WHERE 1 = 1' + sLineBreak + //
     'AND ID_USER = ' + IntToStr(User.Id) + sLineBreak + //
     'ORDER BY PLATE';

  {$IFDEF DEBUG}
  // LogApp('DEBUG', EmptyStr, LSQL);
  {$ENDIF}
  FQry := TFDQuery.Create(nil);
  try
    FQry.Connection := DM.FDConn;

    try
      FQry.Open(LSQL);

      {$REGION 'Carregar Veiculos'}
      if not FQry.IsEmpty then
      begin
        bExists := not FQry.IsEmpty;
        iTotal := FQry.RecordCount;

        if not bExists then
        begin
          Logg.LogApp('APP: Nao foi possivel carregar os veiculos', EmptyStr);
          Exit;
        end;

        if (iTotal = 0) then
        begin
          Logg.LogApp('APP: Sem veiculos para carregar no mapa', EmptyStr);
          Exit;
        end;

        lstvHistoricoPosicoes.AllowSelection := True;
        lstvHistoricoPosicoes.AlternatingColors := True;
        lstvHistoricoPosicoes.AutoTapScroll := True;

        lstvHistoricoPosicoes.CanSwipeDelete := False;
        lstvHistoricoPosicoes.DeleteButtonText := EmptyStr;

        lstvHistoricoPosicoes.SearchVisible := True;
        lstvHistoricoPosicoes.SearchAlwaysOnTop := True;
        lstvHistoricoPosicoes.SelectionCrossfade := False;

        lstvHistoricoPosicoes.ItemAppearance.ItemHeight := 66;

        lstvHistoricoPosicoes.NativeOptions := [TListViewNativeOption.Grouped, TListViewNativeOption.Indexed];

        lstvHistoricoPosicoes.Items.Clear;

        while not FQry.Eof do
        begin
          {$REGION 'Carregar Variaveis'}
          //
          LTerminalId := FQry.FindField('TERMINAL_ID').AsString;
          LEquipmentBrandName := FQry.FindField('EQUIPMENT_BRAND_NAME').AsString;
          LEquipmentModelName := FQry.FindField('EQUIPMENT_MODEL_NAME').AsString;

          LCustomerId := FQry.FindField('CUSTOMER_ID').AsInteger;
          LCustomerName := FQry.FindField('CUSTOMER_NAME').AsString;
          LPlate := FQry.FindField('PLATE').AsString;
          LVehicleBrandName := FQry.FindField('VEHICLE_BRAND_NAME').AsString;
          LVehicleModelName := FQry.FindField('VEHICLE_MODEL_NAME').AsString;
          LVehicleColorId := FQry.FindField('VEHICLE_COLOR_ID').AsInteger;
          LVehicleColor := FQry.FindField('VEHICLE_COLOR').AsString;

          LEventDate := FQry.FindField('EVENT_DATE').AsDateTime;
          LSatellites := FQry.FindField('SATELLITES').AsInteger;
          LLatitude := FQry.FindField('LATITUDE').AsFloat;
          LLongitude := FQry.FindField('LONGITUDE').AsFloat;
          LCourse := FQry.FindField('COURSE').AsInteger;
          LAddress := FQry.FindField('ADDRESS').AsString;

          LIgnitionStatus := FQry.FindField('IGNITION_STATUS').AsBoolean;

          if LIgnitionStatus then
          begin
            LIgnitionStatus_ := cIgnitionOnText;
          end
          else
          begin
            LIgnitionStatus_ := cIgnitionOffText;
          end;

          LSpeed := FQry.FindField('SPEED').AsInteger;
          LOdometer := FQry.FindField('ODOMETER').AsInteger;
          LHorimeter := FQry.FindField('HORIMETER').AsInteger;
          LPowerVoltage := FQry.FindField('POWER_VOLTAGE').AsFloat;

          LCharge := FQry.FindField('CHARGE').AsBoolean;

          if LCharge then
          begin
            // LCharge_ := cBatteryOnText;
            LCharge_ := LPowerVoltage.ToString;
          end
          else
          begin
            // LCharge_ := cBatteryOffText;
            LCharge_ := '0';
          end;

          LBatteryVoltage := FQry.FindField('BATTERY_VOLTAGE').AsInteger;
          LGsmSignalStrength := FQry.FindField('GSM_SIGNAL_STRENGTH').AsInteger;
          LAlarms := FQry.FindField('ALARMS').AsString;

          {$REGION 'Verifica os Dados'}
          if (LTerminalId = EmptyStr) then
            LTerminalId := 'N/D';

          if (LEquipmentBrandName = EmptyStr) then
            LEquipmentBrandName := 'N/D';

          if (LEquipmentModelName = EmptyStr) then
            LEquipmentModelName := 'N/D';

          // if ( LCustomerId: Integer;  LCustomerId := 'N/D';

          if (LCustomerName = EmptyStr) then
            LCustomerName := 'N/D';

          if (LPlate = EmptyStr) then
            LPlate := 'Novo';

          if (LVehicleBrandName = EmptyStr) then
            LVehicleBrandName := 'N/D';

          if (LVehicleModelName = EmptyStr) then
            LVehicleModelName := 'N/D';

          // if ( LVehicleColorId: Integer;  LVehicleColorId := 'N/D';
          // if ( LVehicleColor = EmptyStr ) then  LVehicleColor := 'N/D';
          //
          // if ( LEventDate: TDateTime;  LEventDate := 'N/D';
          // if ( LSatellites: Integer;  LSatellites := 'N/D';
          // if ( LLatitude: double;  LLatitude := 'N/D';
          // if ( LLongitude: double;  LLongitude := 'N/D';
          // if ( LCourse: Integer;  LCourse := 'N/D';
          // if ( LAddress = EmptyStr ) then  LAddress := 'N/D';
          //
          // if ( LIgnitionStatus: Boolean;  LIgnitionStatus := 'N/D';
          // if ( LIgnitionStatus_ = EmptyStr ) then  LIgnitionStatus_ := 'N/D';
          // if ( LSpeed: Integer;  LSpeed := 'N/D';
          // if ( LOdometer: Integer;  LOdometer := 'N/D';
          // if ( LHorimeter: Integer;  LHorimeter := 'N/D';
          // if ( LPowerVoltage: double;  LPowerVoltage := 'N/D';
          // if ( LCharge: Boolean;  LCharge := 'N/D';
          // if ( LCharge_ = EmptyStr ) then  LCharge_ := 'N/D';
          // if ( LBatteryVoltage: Integer;  LBatteryVoltage := 'N/D';
          // if ( LGsmSignalStrength: Integer;  LGsmSignalStrength := 'N/D';
          // if ( LAlarms = EmptyStr ) then  LAlarms := 'N/D';
          {$ENDREGION}
          //

          // LTitle := //
          // RosaDosVentos(LCourse, True) + ' ' + LPlate + //
          // ''; // sLineBreak + LIgnitionStatus_;

          // LData := //
          // '<br><b>Placa: </b>' + LPlate + sLineBreak + //
          // '<br><b>Associado: </b>' + LCustomerName + sLineBreak + //
          // '<br><b>Marca Veíc.: </b>' + LVehicleBrandName + sLineBreak + //
          // '<br><b>Modelo Veíc.: </b>' + LVehicleModelName + sLineBreak + //
          // // '<br><b>Status Ignição: </b> 🔑 ' + LIgnitionStatus_ + sLineBreak + //
          // '<br><b>Status Bateria: </b> 🔋 ' + LCharge_ + sLineBreak + //
          // '<br><b>Últ. Posição: </b> ⏱ ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LEventDate) + sLineBreak + //
          // // '<br><b>Direção: </b>' + RosaDosVentos(LCourse) + sLineBreak + //
          // '<br><b>Odometro: </b>' + IntToStr(LOdometer) + sLineBreak + //
          // '<br><b>Horimetro: </b>' + IntToStr(LHorimeter) + sLineBreak + //
          // '';

          LItem := lstvHistoricoPosicoes.Items.Add;

          with LItem do
          begin
            TagString := LTerminalId;

            LItem.Data['TERMINAL_ID'] := LTerminalId;
            LItem.Data['EQUIPMENT_BRAND_NAME'] := LEquipmentBrandName;
            LItem.Data['EQUIPMENT_MODEL_NAME'] := LEquipmentModelName;
            LItem.Data['CUSTOMER_ID'] := LCustomerId;
            LItem.Data['CUSTOMER_NAME'] := LCustomerName;
            LItem.Data['PLATE'] := LPlate;
            LItem.Data['VEHICLE_BRAND_NAME'] := LVehicleBrandName;
            LItem.Data['VEHICLE_MODEL_NAME'] := LVehicleModelName;
            LItem.Data['VEHICLE_COLOR_ID'] := LVehicleColorId;
            LItem.Data['VEHICLE_COLOR'] := LVehicleColor;
            LItem.Data['EVENT_DATE'] := LEventDate;
            LItem.Data['SATELLITES'] := LSatellites;
            LItem.Data['LATITUDE'] := LLatitude;
            LItem.Data['LONGITUDE'] := LLongitude;
            LItem.Data['COURSE'] := LCourse;
            LItem.Data['ADDRESS'] := LAddress;
            LItem.Data['IGNITION_STATUS'] := LIgnitionStatus;
            LItem.Data['SPEED'] := LSpeed;
            LItem.Data['ODOMETER'] := LOdometer;
            LItem.Data['HORIMETER'] := LHorimeter;
            LItem.Data['POWER_VOLTAGE'] := LPowerVoltage;
            LItem.Data['CHARGE'] := LCharge;
            LItem.Data['BATTERY_VOLTAGE'] := LBatteryVoltage;
            LItem.Data['GSM_SIGNAL_STRENGTH'] := LGsmSignalStrength;
            LItem.Data['ALARMS'] := LAlarms;

            if not(LBitmap = nil) then
              LBitmap := nil;

            LBitmap := TBitmap.Create;

            // {$IFDEF MSWINDOWS}
            if LIgnitionStatus then
            begin
              // BitmapFromBase64(cImageBase64CarOn48, LBitmap);
              // TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap := LBitmap;
              // TListItemText(Objects.FindDrawable('lblEvent1')).TextColor := cIgnitionOnColor;
            end
            else
            begin
              // BitmapFromBase64(cImageBase64CarOff48, LBitmap);
              // TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap := LBitmap;
              // TListItemText(Objects.FindDrawable('lblEvent1')).TextColor := cIgnitionOffColor;
            end;

            if LCharge then
            begin
              // TListItemText(Objects.FindDrawable('lblEvent2')).TextColor := cBatteryOnColor;
            end
            else
            begin
              // TListItemText(Objects.FindDrawable('lblEvent2')).TextColor := cBatteryOffColor;
            end;

            // {$ENDIF}
            // {$IFDEF ANDROID}
            // if LIgnitionStatus then
            // begin
            // TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap.LoadFromURL(cImageBase64CarOn48);
            // end
            // else
            // begin
            // TListItemImage(Objects.FindDrawable('imgVeiculo')).Bitmap.LoadFromURL(cImageBase64CarOff48);
            // end;
            // {$ENDIF}

            TListItemText(Objects.FindDrawable('lblPlaca')).Text := LPlate;
            TListItemText(Objects.FindDrawable('lblPlaca')).Font.Size := 12;
            TListItemText(Objects.FindDrawable('lblPlaca')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblEventoData')).Text := //
               'Evento: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LEventDate) + ' - ' + //
               'Ignição: ' + LIgnitionStatus_;
            TListItemText(Objects.FindDrawable('lblEventoData')).Font.Size := 12;
            TListItemText(Objects.FindDrawable('lblEventoData')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblLogradouro')).Text := LAddress;
            TListItemText(Objects.FindDrawable('lblLogradouro')).Font.Size := 9;
            TListItemText(Objects.FindDrawable('lblLogradouro')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblVelocidade')).Text := 'Velocidade: ' + LSpeed.ToString + ' km/h';
            TListItemText(Objects.FindDrawable('lblVelocidade')).Font.Size := 10;
            TListItemText(Objects.FindDrawable('lblVelocidade')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblVoltagem')).Text := 'Voltagem: ' + LPowerVoltage.ToString;
            TListItemText(Objects.FindDrawable('lblVoltagem')).Font.Size := 10;
            TListItemText(Objects.FindDrawable('lblVoltagem')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblOdometro')).Text := 'Odômetro: ' + LOdometer.ToString;
            TListItemText(Objects.FindDrawable('lblOdometro')).Font.Size := 10;
            TListItemText(Objects.FindDrawable('lblOdometro')).TextAlign := TTextAlign.Leading;

            TListItemText(Objects.FindDrawable('lblHorimetro')).Text := 'Horímetro: ' + LHorimeter.ToString;
            TListItemText(Objects.FindDrawable('lblHorimetro')).Font.Size := 10;
            TListItemText(Objects.FindDrawable('lblHorimetro')).TextAlign := TTextAlign.Leading;
          end;

          {$ENDREGION}
          FQry.Next;
        end;
      end;
      {$ENDREGION}
    except
      on E: Exception do
      begin
        Logg.LogAppSQL( //
           'TFrmMain.carregarVeiculos' //
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

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  LoadFormState;

  {$IFDEF MSWINDOWS}
  Self.Left := 16;
  Self.Top := 16;
  Self.Height := 720;
  Self.Width := 480;

  Self.Fill.Color := $FFFFFFFF;
  edtLoginNome.TextSettings.FontColor := $FF000000;
  edtLoginSenha.TextSettings.FontColor := $FF000000;
  lblEsqueciSenha.TextSettings.FontColor := $FF000000;
  lblSempreLogado.TextSettings.FontColor := $FF000000;
  lblSempreLogado.Text := PadL(lblSempreLogado.Text, Trunc(swtSempreLogado.Width), ' ');

  tbcMain.TabPosition := TTabPosition.Dots;
  {$ENDIF}
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([ //
     PermissionReadExternalStorage //
     , PermissionWriteExternalStorage //
     ], PermissionResult, PermissionMessage);
  {$ENDIF}
  User := TUser.Create;
  Login := TLogin.Create;
  PositionLast := TPositionLast.Create;

  DM.doCreateDB;

  mvMenuView.Width := Self.Width - 80;
  grdLytMenuMapa.ItemWidth := Trunc(Self.Width / 6) - 0;
  tbcMain.ActiveTab := tbiLogin;

  FPanelMap := TPanel.Create(Self);
  FPanelMap.Parent := lytMapa;
  FPanelMap.Align := TAlignLayout.Client;

  Map := TTMSFNCGoogleMaps.Create(lytMapa);
  Map.APIKey := cGoogleMapsWebAPI;
  Map.Options.Locale := 'pt-BR';

  Map.Options.DefaultLatitude := cLat;
  Map.Options.DefaultLongitude := cLng;
  Map.Options.DefaultZoomLevel := cZoom;

  Map.OnCustomizeHeadLinks := doCustomizeHeadLinks;
  Map.OnMapInitialized := doMapInitialized;
  Map.OnMarkerClick := doMarkerClick;

  Map.Align := TAlignLayout.Client;
  Map.Parent := FPanelMap;

  Map.Enabled := True;
  Map.Visible := True;

  FPanelMap.Enabled := True;
  FPanelMap.Visible := True;

  IsPositionFirst := True;

  tbcMain.TabPosition := TTabPosition.None;

  { todo -o@WOS83:Esconde a Lista de Veículos }
  lytListaVeiculos.Visible := False;

  FImageCarOn48 := cImageUrlCarOn48;
  FImageCarOff48 := cImageUrlCarOff48;

  // FTimerPositionHistory := TTimer.Create(Self);
  // FTimerPositionHistory.Enabled := False;
  // FTimerPositionHistory.Interval := 15000;
  // FTimerPositionHistory.OnTimer := doUpdatePositionHistory;

  FTimerDrawOnMap := TTimer.Create(Self);
  FTimerDrawOnMap.Enabled := False;
  FTimerDrawOnMap.Interval := 1500;
  FTimerDrawOnMap.OnTimer := doUpdateDrawOnMap;

  edtLoginNome.Text := 'william';
  edtLoginSenha.Text := '#h#p0te5YZ';
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  User.Destroy;
  Login.Destroy;
  PositionLast.Destroy;

  {$IFDEF MSWINDOWS}
  FreeAndNil(Map);
  FreeAndNil(FPanelMap);
  FreeAndNil(FTimerDrawOnMap);
  {$ELSE}
  Map.DisposeOf;
  FPanelMap.DisposeOf;
  // FTimerDrawOnMap.DisposeOf;
  {$ENDIF}
end;

procedure TFrmMain.FormSaveState(Sender: TObject);
begin
  SaveFormState;
end;

procedure TFrmMain.lblEntrarClick(Sender: TObject);
begin
  TLoading.Show(FrmMain, 'Carregando dados do usuário..');
  TThread.Queue(nil,
    procedure
    begin
      fazerLogin;
      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
        end);
    end);
end;

procedure TFrmMain.lstvListaVeiculosItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  LLatitude: double;
  LLongitude: double;

  LLatitude_: string;
  LLongitude_: string;
begin
  if mvMenuView.Visible then
  begin
    FPanelMap.Opacity := 1;
    FPanelMap.Visible := True;
    mvMenuView.HideMaster;
    mvMenuView.Visible := False;
  end;

  Map.Visible := True;
  lytMapa.Visible := True;
  lytMapa.BringToFront;

  FPanelMap.BringToFront;
  FPanelMap.Opacity := 1;

  lytListaVeiculos.SendToBack;
  lytListaVeiculos.Visible := False;

  LLatitude_ := AItem.Data['LATITUDE'].AsVariant;
  LLatitude := StrToFloat(LLatitude_);

  LLongitude_ := AItem.Data['LONGITUDE'].AsVariant;
  LLongitude := StrToFloat(LLongitude_);

  Map.SetCenterCoordinate(LLatitude, LLongitude);
  Map.SetZoomLevel(21);
end;

procedure TFrmMain.mvMenuViewStartHiding(Sender: TObject);
begin
  FPanelMap.Opacity := 1;
  FPanelMap.Visible := True;
  mvMenuView.Visible := False;
end;

procedure TFrmMain.mvMenuViewStartShowing(Sender: TObject);
begin
  FPanelMap.Opacity := 0.3;
  FPanelMap.Visible := False;
  mvMenuView.Visible := True;
end;

procedure TFrmMain.rectBtnListaVeiculosClick(Sender: TObject);
begin
  doListaVeiculos;
end;

procedure TFrmMain.btnMenuHistoricoPosicoesClick(Sender: TObject);
begin
  doHistoricoPosicoes;
end;

procedure TFrmMain.btnMenuListaVeiculosClick(Sender: TObject);
begin
  doListaVeiculos;
end;

procedure TFrmMain.btnMenuMostraMapaClick(Sender: TObject);
begin
  doMostraMapa;
end;

procedure TFrmMain.rectBtnMostraMapaClick(Sender: TObject);
begin
  doMostraMapa;
end;

procedure TFrmMain.actMostrarMapaExecute(Sender: TObject);
begin
  doMostraMapa;
end;

procedure TFrmMain.actComandosExecute(Sender: TObject);
begin
  ShowMessage('Em fase de teste no Depto. de Desenvolvimento!');
end;

procedure TFrmMain.actConfiguracoesExecute(Sender: TObject);
begin
  ShowMessage('Em fase de teste no Depto. de Desenvolvimento!');
end;

procedure TFrmMain.actEventosExecute(Sender: TObject);
begin
  ShowMessage('Em fase de teste no Depto. de Desenvolvimento!');
end;

procedure TFrmMain.actHistoricoPosicoesExecute(Sender: TObject);
begin
  doHistoricoPosicoes;
end;

procedure TFrmMain.actListarVeiculosExecute(Sender: TObject);
begin
  doListaVeiculos;
end;

procedure TFrmMain.imgBtnHistoricoPosicoesClick(Sender: TObject);
begin
  doHistoricoPosicoes;
end;

procedure TFrmMain.imgBtnListaVeiculosClick(Sender: TObject);
begin
  doListaVeiculos;
end;

procedure TFrmMain.imgBtnMostraMapaClick(Sender: TObject);
begin
  doMostraMapa;
end;

procedure TFrmMain.imgMenuListaVeiculosClick(Sender: TObject);
begin
  doListaVeiculos;
end;

procedure TFrmMain.imgMenuMostraMapaClick(Sender: TObject);
begin
  doMostraMapa;
end;

procedure TFrmMain.btnListaVeiculos2_Click(Sender: TObject);
begin
  doListaVeiculos;
end;

// * Testando *//

end.
