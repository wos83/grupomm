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
  FMX.Layouts,
  FMX.ListBox,
  FMX.Maps,
  FMX.Media,
  FMX.MediaLibrary.Actions,
  FMX.Objects,
  FMX.Platform,
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
  System.Math,
  System.Generics.Collections,
  System.Actions,
  System.Classes,
  System.IOUtils,
  System.Permissions,
  System.Sensors,
  System.Sensors.Components,
  System.SysUtils,
  System.Types,
  System.UIConsts,
  System.UITypes,
  System.Variants,
  System.ImageList,
  FMX.ImgList,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  //
  uConsts,
  uLibrary,
  uDM;

type
  TFrmMain = class(TForm)
    edtLoginNome: TEdit;
    edtLoginSenha: TEdit;
    imgBtnListaVeiculos: TImage;
    imgBtnMenu: TImage;
    imglMain128: TImageList;
    imgLogo: TImage;
    lblEntrar: TLabel;
    lblEsqueciSenha: TLabel;
    lblLoginNome: TLabel;
    lblLoginSenha: TLabel;
    lblTituloMapa: TLabel;
    lstvListaVeiculos: TListView;
    lytBtnListaVeiculos: TLayout;
    lytContentLogin: TLayout;
    lytContentMapa: TLayout;
    lytEntrar: TLayout;
    lytListaVeiculos: TLayout;
    lytLogar: TLayout;
    lytLoginNome: TLayout;
    lytLoginSenha: TLayout;
    lytLogo: TLayout;
    lytMapa: TLayout;
    lytTituloMapa: TLayout;
    MapView1: TMapView;
    rectBtnEntrar: TRectangle;
    rectBtnMenu: TRectangle;
    rectMenuMapa: TRectangle;
    rectNavMapa: TRectangle;
    tbcMain: TTabControl;
    tbiLogin: TTabItem;
    tbiMapa: TTabItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure imgBtnListaVeiculosClick(Sender: TObject);
    procedure lblEntrarClick(Sender: TObject);
    procedure lstvListaVeiculosItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);

    procedure MapView1CameraChanged(Sender: TObject);
    procedure MapView1Gesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure MapView1MapClick(const Position: TMapCoordinate);
    procedure MapView1MapDoubleClick(const Position: TMapCoordinate);
    procedure MapView1MapLongClick(const Position: TMapCoordinate);
    procedure MapView1MarkerClick(Marker: TMapMarker);
    procedure MapView1MarkerDoubleClick(Marker: TMapMarker);
    procedure MapView1MarkerDrag(Marker: TMapMarker);
    procedure MapView1MarkerDragEnd(Marker: TMapMarker);
    procedure MapView1MarkerDragStart(Marker: TMapMarker);
    procedure MapView1Tap(Sender: TObject; const Point: TPointF);
  private
    FPanelMap: TPanel;
    FTimerPositionLast: TTimer;
    FTimerDrawOnMap: TTimer;

    FCar128: TImage;

    {$IFDEF ANDROID}
    procedure PermissionMessage(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure PermissionResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    {$ENDIF}
    procedure loginUsuario;
    procedure listarVeiculos;

    procedure doUpdatePositionLast(Sender: TObject);
    procedure doMarkersCleanAll;
    procedure doUpdateDrawOnMap(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  Map: TMapView;
  MapMarkerArray: array of TMapMarker;

const
  cCACHE = 'cache';
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
  cZoom = 9;

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

procedure TFrmMain.loginUsuario;
var
  LUsername: string;
  LPassword: string;
  LError: string;
  LLogin: Boolean;
  LMapCoordinate: TMapCoordinate;
begin
  LLogin := False;
  LError := EmptyStr;

  LUsername := edtLoginNome.Text;
  LPassword := edtLoginSenha.Text;

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

  LLogin := DM.doLogin(LUsername, LPassword, EmptyStr);

  if LLogin then
  begin
    Toast(FUser.Name + ', login realizado com sucesso!', 3);

    FTimerPositionLast.Enabled := True;
    FTimerDrawOnMap.Enabled := True;

    tbcMain.ActiveTab := tbiMapa;

    LMapCoordinate := TMapCoordinate.Create(cLat, cLng);

    Map.Location := LMapCoordinate;
    Map.Zoom := cZoom;

    Map.Visible := True;
  end;

  if not(LError = EmptyStr) then
  begin
    TDialogService.ShowMessage(cMSG_SUPORTE + sLineBreak + LError);
    Exit;
  end;
end;

procedure TFrmMain.doUpdatePositionLast(Sender: TObject);
begin
  TThread.Queue(nil,
    procedure
    begin
      DM.doPositionLast(FUser.TokenCredential);
    end);
end;

procedure TFrmMain.doMarkersCleanAll;
var
  LInt: Integer;
begin
  if High(MapMarkerArray) > -1 then
    for LInt := 0 to High(MapMarkerArray) do
      if Assigned(MapMarkerArray[LInt]) then
        MapMarkerArray[LInt].Remove;

  SetLength(MapMarkerArray, 0);
end;

procedure TFrmMain.doUpdateDrawOnMap(Sender: TObject);
var
  FQry: TFDQuery;
  LSQL: string;

  bExists: Boolean;
  iTotal: Integer;

  LCaracter: Integer;

  LCol: Integer;
  LRow: Integer;

  LMapCoordinate: TMapCoordinate;
  LInfo: TMapMarkerDescriptor;

  LRect: TRectF;
  LLeft, LTop, LRight, LBottom: Integer;
  LLine: TLineMetricInfo;

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

  LIgnitionStatus: Boolean;
  LSpeed: Integer;
  LOdometer: Integer;
  LHorimeter: Integer;
  LPowerVoltage: double;
  LCharge: Boolean;
  LBatteryVoltage: Integer;
  LGsmSignalStrength: Integer;
  LAlarms: string;

const
  cCaracter = 80;

begin
  LSQL := //
     'SELECT *' + sLineBreak + //
     'FROM POSITIONS_LAST' + sLineBreak + //
     'WHERE 1 = 1' + sLineBreak + //
     'AND ID_USER = ' + IntToStr(FUser.Id) + sLineBreak + //
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
          LogApp('APP: Nao foi possivel carregar os veiculos', EmptyStr, EmptyStr);
          Exit;
        end;

        if (iTotal = 0) then
        begin
          LogApp('APP: Sem veiculos para carregar no mapa', EmptyStr, EmptyStr);
          Exit;
        end;

        doMarkersCleanAll;

        while not FQry.Eof do
        begin
          Application.ProcessMessages;

          {$REGION 'Carregar Vriaveis'}
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
          // LCourse := FQry.FindField('COURSE').AsInteger;
          LAddress := FQry.FindField('ADDRESS').AsString;

          LIgnitionStatus := FQry.FindField('IGNITION_STATUS').AsBoolean;
          LSpeed := FQry.FindField('SPEED').AsInteger;
          LOdometer := FQry.FindField('ODOMETER').AsInteger;
          LHorimeter := FQry.FindField('HORIMETER').AsInteger;
          LPowerVoltage := FQry.FindField('POWER_VOLTAGE').AsFloat;
          LCharge := FQry.FindField('CHARGE').AsBoolean;
          LBatteryVoltage := FQry.FindField('BATTERY_VOLTAGE').AsInteger;
          LGsmSignalStrength := FQry.FindField('GSM_SIGNAL_STRENGTH').AsInteger;
          LAlarms := FQry.FindField('ALARMS').AsString;

          { todo -oWOS:Posição Atual no Mapa }
          LMapCoordinate := TMapCoordinate.Create(LLatitude, LLongitude);

          LInfo := TMapMarkerDescriptor.Create(LMapCoordinate, 'VEICULOS');

          LInfo.Appearance := TMarkerAppearance.Flat;
          LInfo.Position := LMapCoordinate;
          LInfo.Rotation := LCourse;

          LInfo.Icon := FCar128.Bitmap;

          LCaracter := Length(LPlate) + 3 + Length(LCustomerName);
          if not(LCaracter >= cCaracter) then
            LInfo.Title := Copy((LPlate + ' - ' + LCustomerName + SpaceBlank(255)), 1, LCaracter)
          else
            LInfo.Title := Copy((LPlate + ' - ' + LCustomerName), 1, LCaracter);

          LInfo.Snippet := LEquipmentBrandName + ' - ' + LEquipmentModelName;

          LInfo.Opacity := 1;
          LInfo.Visible := True;

          Map.AddMarker(LInfo);

          //
          {$ENDREGION}
          FQry.Next;
        end;
      end;
      {$ENDREGION}
    except
      on E: Exception do
      begin
        LogApp( //
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

  // if not(FUltimaPosicao = nil) then
  // begin
  // for LRow := Low(FUltimaPosicao) to High(FUltimaPosicao) do
  // begin
  // for LCol := Low(FUltimaPosicao[LRow]) to High(FUltimaPosicao[LRow]) do
  // begin
  // Application.ProcessMessages;
  //
  // LDeviceId := 'SN: ' + FUltimaPosicao[LRow, 0];
  // LNome := 'Veículo: ' + FUltimaPosicao[LRow, 1];
  // LPlaca := 'Placa: ' + FUltimaPosicao[LRow, 2];
  //
  // // TLoading.MessageChange(FUltimaPosicao[LRow, 1] + ' - ' + FUltimaPosicao[LRow, 2]);
  //
  // sLatitude := StringReplace(FUltimaPosicao[LRow, 3], '.', ',', [rfReplaceAll]);
  // sLongitude := StringReplace(FUltimaPosicao[LRow, 4], '.', ',', [rfReplaceAll]);
  // sDirection := StringReplace(FUltimaPosicao[LRow, 5], '.', ',', [rfReplaceAll]);
  //
  // LLatitude := StrToFloatDef(sLatitude, 0);
  // LLongitude := StrToFloatDef(sLongitude, 0);
  // LDirection := StrToFloatDef(sDirection, 0);
  //
  // try
  // // LAddress := 'Endereço: ' + Map.GetAddressFromLatLng(LLatitude, LLongitude);
  // except
  // end;
  //
  // LData := 'Data: ' + Copy(FUltimaPosicao[LRow, 6], 1, 10);
  // LHora := 'Hora: ' + Copy(FUltimaPosicao[LRow, 6], 11, 10);
  //
  // LEvent1 := 'Evento 1: ' + FUltimaPosicao[LRow, 7];
  // LEvent2 := 'Evento 2: ' + FUltimaPosicao[LRow, 8];
  //
  // LContent := //
  // LNome + sLineBreak + //
  // LPlaca + sLineBreak + //
  // 'Latitude: ' + LLatitude.ToString + sLineBreak + //
  // 'Longitude: ' + LLongitude.ToString + sLineBreak + //
  // 'Direção: ' + Round(LDirection).ToString + sLineBreak + //
  // // LAddress + sLineBreak + //
  // LData + sLineBreak + //
  // LHora + sLineBreak + //
  // LEvent1 + sLineBreak + //
  // LEvent2 + sLineBreak + //
  // LDeviceId + sLineBreak + //
  // '';
  //
  // {$REGION 'Ponto do Veículo no Mapa'}
  // LMapCoordinate := TMapCoordinate.Create(LLatitude, LLongitude);
  // LInfo := TMapMarkerDescriptor.Create(LMapCoordinate, 'VEICULOS');
  //
  // LInfo.Icon := FCar128.Bitmap;
  //
  // LLeft := 8;
  // LTop := 8;
  // LRight := 8;
  // LBottom := 8;
  //
  // LRect := TRectF.Create(LLeft, LTop, LRight, LBottom);
  //
  // LInfo.Icon.Canvas.BeginScene;
  // LInfo.Icon.Canvas.Fill.Color := TAlphaColors.Black;
  //
  // LInfo.Icon.Canvas.FillText( //
  // LRect //
  // , LPlaca //
  // , False //
  // , 1 //
  // , [TFillTextFlag.RightToLeft] //
  // , TTextAlign.Center //
  // , TTextAlign.Center);
  //
  // LInfo.Icon.Canvas.EndScene;
  //
  // LInfo.Position := LMapCoordinate;
  // LInfo.Opacity := 1;
  // LInfo.Title := LPlaca;
  // LInfo.Snippet := LNome;
  // LInfo.Draggable := False;
  // LInfo.Visible := True;
  // // LInfo.Rotation := LDirection;
  // LInfo.Appearance := TMarkerAppearance.Flat;
  //
  // // LItem := Map.AddMarker(LInfo);
  // Map.AddMarker(LInfo);
  // {$ENDREGION}
  // end;
  // end;
  // Toast('Veículos carregados', 3);
  // end;
end;

procedure TFrmMain.listarVeiculos;
var
  LCol: Integer;
  LRow: Integer;

  LSQL: string;

  LInt: Integer;

  LField: string;
  LValue: string;

  LItem: TListItemView;

  LDeviceId: string;
  LNome: string;
  LPlaca: string;
  LLatitude: string;
  LLongitude: string;
  LDirection: string;
  LUltPos: string;
  LEvent1: string;
  LEvent2: string;
begin
  lstvListaVeiculos.Items.Clear;

  // if not(FUltimaPosicao = nil) then
  // begin
  // for LRow := Low(FUltimaPosicao) to High(FUltimaPosicao) do
  // begin
  // for LCol := Low(FUltimaPosicao[LRow]) to High(FUltimaPosicao[LRow]) do
  // begin
  // Application.ProcessMessages;
  //
  // LDeviceId := FUltimaPosicao[LRow, 0];
  // LNome := FUltimaPosicao[LRow, 1];
  // LPlaca := FUltimaPosicao[LRow, 2];
  //
  // LLatitude := FUltimaPosicao[LRow, 3];
  // LLongitude := FUltimaPosicao[LRow, 4];
  // LDirection := FUltimaPosicao[LRow, 5];
  //
  // LUltPos := FUltimaPosicao[LRow, 6];
  // LEvent1 := FUltimaPosicao[LRow, 7];
  // LEvent2 := FUltimaPosicao[LRow, 8];
  //
  // with lstvListaVeiculos.Items.add do
  // begin
  // Height := 50;
  // TagString := LDeviceId;
  //
  // TListItemText(Objects.FindDrawable('lblVeiculo')).Text := LPlaca;
  // TListItemText(Objects.FindDrawable('lblVeiculo')).Font.Size := 10;
  //
  // TListItemText(Objects.FindDrawable('lblDescricao')).Text := LNome;
  // TListItemText(Objects.FindDrawable('lblDescricao')).Font.Size := 9;
  //
  // TListItemText(Objects.FindDrawable('lblEvent1')).Text := LEvent1;
  // TListItemText(Objects.FindDrawable('lblEvent1')).Font.Size := 9;
  //
  // TListItemText(Objects.FindDrawable('lblEvent2')).Text := LEvent2;
  // TListItemText(Objects.FindDrawable('lblEvent2')).Font.Size := 9;
  // end;
  // end;
  // end;
  // end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  LDir: string;
  LImageCar128: string;
begin
  {$IFDEF MSWINDOWS}
  Self.Left := 16;
  Self.Top := 16;
  Self.Height := 720;
  Self.Width := 480;

  Self.Fill.Color := $FFFFFFFF;
  edtLoginNome.TextSettings.FontColor := $FF000000;
  edtLoginSenha.TextSettings.FontColor := $FF000000;

  tbcMain.TabPosition := TTabPosition.Dots;

  LDir := ExtractFileDir(ParamStr(0)) + PathDelim + cCACHE;
  {$ENDIF}
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([ //
     PermissionReadExternalStorage //
     , PermissionWriteExternalStorage //
     ], PermissionResult, PermissionMessage);

  LDir := TPath.GetDocumentsPath + PathDelim + cCACHE;
  {$ENDIF}
  DM.doCreateDB;

  if not DirectoryExists(LDir) then
    ForceDirectories(LDir);

  tbcMain.ActiveTab := tbiLogin;

  FPanelMap := TPanel.Create(Self);
  FPanelMap.Parent := lytMapa;
  FPanelMap.Align := TAlignLayout.Client;

  Map := TMapView.Create(lytMapa);

  Application.ProcessMessages;

  Map.MapType := TMapType.Normal;
  Map.Tilt := 68;

  Map.Align := TAlignLayout.Client;
  Map.Parent := FPanelMap;

  tbcMain.TabPosition := TTabPosition.None;

  { todo: -cWOS: Esconde a Lista de Veículos }
  lytListaVeiculos.Visible := False;

  {$IFDEF MSWINDOWS}
  LImageCar128 := TPath.Combine(ExtractFileDir(ParamStr(0)), cImageCar128);
  {$ENDIF}
  {$IFDEF ANDROID}
  LImageCar128 := TPath.Combine(TPath.GetDocumentsPath, cImageCar128);
  {$ENDIF}
  FCar128 := TImage.Create(Self);

  if FileExists(LImageCar128) then
  begin
    FCar128.Bitmap.LoadFromFile(LImageCar128);
    FCar128.Visible := True;
  end;

  FTimerPositionLast := TTimer.Create(Self);
  FTimerPositionLast.Interval := 5000;
  FTimerPositionLast.Enabled := False;
  FTimerPositionLast.OnTimer := doUpdatePositionLast;

  FTimerDrawOnMap := TTimer.Create(Self);
  FTimerDrawOnMap.Interval := 15000;
  FTimerDrawOnMap.Enabled := False;
  FTimerDrawOnMap.OnTimer := doUpdateDrawOnMap;

  edtLoginNome.Text := 'william';
  edtLoginSenha.Text := '#h#p0te5YZ';
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  FreeAndNil(FCar128);
  FreeAndNil(Map);
  FreeAndNil(FPanelMap);
  {$ELSE}
  FCar128.DisposeOf;
  Map.DisposeOf;
  FPanelMap.DisposeOf;
  {$ENDIF}
end;

procedure TFrmMain.lblEntrarClick(Sender: TObject);
begin
  TThread.Queue(nil,
    procedure
    begin
      loginUsuario;
    end);
end;

procedure TFrmMain.imgBtnListaVeiculosClick(Sender: TObject);
begin
  Map.Opacity := 0.3;
  Map.Visible := False;
  lytListaVeiculos.BringToFront;

  TThread.Queue(nil,
    procedure
    begin
      listarVeiculos;
    end);

  lytListaVeiculos.Visible := True;
end;

procedure TFrmMain.lstvListaVeiculosItemClickEx(const Sender: TObject; ItemIndex: Integer; //
const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
  Map.Opacity := 1;
  Map.Visible := True;
  lytListaVeiculos.SendToBack;
  lytListaVeiculos.Visible := False;
end;

procedure TFrmMain.MapView1CameraChanged(Sender: TObject);
begin
  //
end;

procedure TFrmMain.MapView1Gesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  //
end;

procedure TFrmMain.MapView1MapClick(const Position: TMapCoordinate);
begin
  //
end;

procedure TFrmMain.MapView1MapDoubleClick(const Position: TMapCoordinate);
begin
  //
end;

procedure TFrmMain.MapView1MapLongClick(const Position: TMapCoordinate);
begin
  //
end;

procedure TFrmMain.MapView1MarkerClick(Marker: TMapMarker);
begin
  //
end;

procedure TFrmMain.MapView1MarkerDoubleClick(Marker: TMapMarker);
begin
  //
end;

procedure TFrmMain.MapView1MarkerDrag(Marker: TMapMarker);
var
  c: TMapCoordinate;
  m: TMapMarkerDescriptor;
begin
  //
  c.Create(Map.Location.Latitude, Map.Location.Longitude);
  m.Create(c, EmptyStr);
  Marker.Descriptor.Create(c, 'MapView1MarkerDrag');
end;

procedure TFrmMain.MapView1MarkerDragEnd(Marker: TMapMarker);
var
  c: TMapCoordinate;
  m: TMapMarkerDescriptor;
begin
  //
  c.Create(Map.Location.Latitude, Map.Location.Longitude);
  m.Create(c, 'MapView1MarkerDragEnd');
  Marker.Descriptor.Create(c, EmptyStr);
end;

procedure TFrmMain.MapView1MarkerDragStart(Marker: TMapMarker);
var
  c: TMapCoordinate;
  m: TMapMarkerDescriptor;
begin
  //
  c.Create(Map.Location.Latitude, Map.Location.Longitude);
  m.Create(c, 'MapView1MarkMapView1MarkerDragStarterDragEnd');
  Marker.Descriptor.Create(c, EmptyStr);
end;

procedure TFrmMain.MapView1Tap(Sender: TObject; const Point: TPointF);
begin
  //
end;

end.
