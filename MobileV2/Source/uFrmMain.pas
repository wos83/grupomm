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
  FMX.TMSFNCCloudBase,
  FMX.TMSFNCCustomControl,
  FMX.TMSFNCGeoCoding,
  FMX.TMSFNCGoogleMaps,
  FMX.TMSFNCGraphics,
  FMX.TMSFNCGraphicsTypes,
  FMX.TMSFNCMaps,
  FMX.TMSFNCMapsCommonTypes,
  FMX.TMSFNCTypes,
  FMX.TMSFNCUtils,
  FMX.TMSFNCWebBrowser,
  //
  System.Actions,
  System.AnsiStrings,
  System.Classes,
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
  uConsts,
  uLibrary,
  uDM;

type
  TFrmMain = class(TForm)
    edtLoginNome: TEdit;
    edtLoginSenha: TEdit;
    imgBtnListaVeiculos: TImage;
    imgBtnMenu: TImage;
    imglMain48: TImageList;
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
    rectBtnEntrar: TRectangle;
    rectBtnMenu: TRectangle;
    rectMenuMapa: TRectangle;
    rectNavMapa: TRectangle;
    tbcMain: TTabControl;
    tbiLogin: TTabItem;
    tbiMapa: TTabItem;
    TMSFNCGoogleMapsDebug: TTMSFNCGoogleMaps;
    ImageList128: TImageList;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure imgBtnListaVeiculosClick(Sender: TObject);
    procedure lblEntrarClick(Sender: TObject);
    procedure lstvListaVeiculosItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);

  private
    FPanelMap: TPanel;
    FTimerPositionLast: TTimer;
    FTimerDrawOnMap: TTimer;

    FImageCarOn48: string;
    FImageCarOff48: string;

    {$IFDEF ANDROID}
    procedure PermissionMessage(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure PermissionResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    {$ENDIF}
    procedure loginUsuario;
    procedure listarVeiculos;

    procedure doUpdatePositionLast(Sender: TObject);
    procedure doUpdateDrawOnMap(Sender: TObject);
    procedure doMarkerClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    procedure doOverlayViewClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  Map: TTMSFNCGoogleMaps;

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
  cZoom = 8;

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

    Map.Options.DefaultLatitude := cLat;
    Map.Options.DefaultLongitude := cLng;
    Map.Options.DefaultZoomLevel := cZoom;

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
      try
        FTimerPositionLast.Enabled := False;
        DM.doPositionLast(FUser.TokenCredential);
      finally
        FTimerPositionLast.Interval := 30000;
        FTimerPositionLast.Enabled := True;
      end;
    end);
end;

procedure TFrmMain.doMarkerClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
begin
  Map.ShowPopup( //
     AEventData.Coordinate.Latitude //
     , AEventData.Coordinate.Longitude //
     , AEventData.Marker.DataString //
     , 0 //
     , 0);
end;

procedure TFrmMain.doOverlayViewClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
begin
  Map.ShowPopup( //
     AEventData.Coordinate.Latitude //
     , AEventData.Coordinate.Longitude //
     , AEventData.Marker.DataString //
     , 0 //
     , 0);
end;

procedure TFrmMain.doUpdateDrawOnMap(Sender: TObject);
var
  FQry: TFDQuery;
  LSQL: string;

  bExists: Boolean;
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

  LIgnitionStatus: Boolean;
  LIgnitionStatus_: string;
  LSpeed: Integer;
  LOdometer: Integer;
  LHorimeter: Integer;
  LPowerVoltage: double;
  LCharge: Boolean;
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

              Map.Markers.Clear;

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
                  LCharge_ := cBatteryOnText;
                end
                else
                begin
                  LCharge_ := cBatteryOffText;
                end;

                LBatteryVoltage := FQry.FindField('BATTERY_VOLTAGE').AsInteger;
                LGsmSignalStrength := FQry.FindField('GSM_SIGNAL_STRENGTH').AsInteger;
                LAlarms := FQry.FindField('ALARMS').AsString;

                LTitle := //
                   RosaDosVentos(LCourse, True) + ' ' + LPlate;

                LData := //
                   '<br><b>Cliente: </b>' + LCustomerName + sLineBreak + //
                   '<br><b>Placa: </b>' + LPlate + sLineBreak + //
                   '<br><b>Marca Veíc.: </b>' + LVehicleBrandName + sLineBreak + //
                   '<br><b>Modelo Veíc.: </b>' + LVehicleModelName + sLineBreak + //
                   '<br><b>Status Ignição: </b> 🔑 ' + LIgnitionStatus_ + sLineBreak + //
                   '<br><b>Status Bateria: </b> 🔋 ' + LCharge_ + sLineBreak + //
                   '<br><b>Últ. Posição: </b> ⏱ ' + formatdatetime('dd/mm/yyyy hh:nn:ss', LEventDate) + sLineBreak + //
                   '<br><b>Direção: </b>' + RosaDosVentos(LCourse) + sLineBreak + //
                   '<br><b>Odometro: </b>' + IntToStr(LOdometer) + sLineBreak + //
                   '<br><b>Horimetro: </b>' + IntToStr(LHorimeter) + sLineBreak + //
                   '';
                { todo -o@WOS83:Posição Atual no Mapa }
                Map.BeginUpdate;

                LMarker := Map.Markers.Add;
                LMarker.Latitude := LLatitude;
                LMarker.Longitude := LLongitude;

                LMarker.Clickable := True;

                LMarker.Title := LTitle;
                LMarker.DataString := LData;

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
                  LMarker.IconURL := FImageCarOn48
                else
                  LMarker.IconURL := FImageCarOff48;
                {$ENDIF}
                LOverlayView := Map.AddOverlayView;
                LOverlayView.Clickable := True;
                LOverlayView.CoordinateOffsetTop := 16;

                LOverlayView.Mode := omCoordinate;
                LOverlayView.Coordinate.Latitude := LLatitude;
                LOverlayView.Coordinate.Longitude := LLongitude;
                LOverlayView.CoordinatePosition := cpBottomLeft;

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

                Map.EndUpdate;
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

  bExists: Boolean;
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

  LIgnitionStatus: Boolean;
  LIgnitionStatus_: string;
  LSpeed: Integer;
  LOdometer: Integer;
  LHorimeter: Integer;
  LPowerVoltage: double;
  LCharge: Boolean;
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

        lstvListaVeiculos.Items.Clear;

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
            LCharge_ := cBatteryOnText;
          end
          else
          begin
            LCharge_ := cBatteryOffText;
          end;

          LBatteryVoltage := FQry.FindField('BATTERY_VOLTAGE').AsInteger;
          LGsmSignalStrength := FQry.FindField('GSM_SIGNAL_STRENGTH').AsInteger;
          LAlarms := FQry.FindField('ALARMS').AsString;

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

  if not(DM.FPositionLast = nil) then
  begin
    if not DM.FPositionLast.Active then
      Exit;

    while not DM.FPositionLast.Eof do
    begin
      Application.ProcessMessages;

      LPlaca := DM.FPositionLast.FindField('plate').AsString;
      LNome := DM.FPositionLast.FindField('customer_name').AsString;
      LIgnicaoStatus := DM.FPositionLast.FindField('customer_name').AsString;

      with lstvListaVeiculos.Items.Add do
      begin
        Height := 50;
        TagString := LDeviceId;

        TListItemText(Objects.FindDrawable('lblVeiculo')).Text := LPlaca;
        TListItemText(Objects.FindDrawable('lblVeiculo')).Font.Size := 10;

        TListItemText(Objects.FindDrawable('lblDescricao')).Text := LNome;
        TListItemText(Objects.FindDrawable('lblDescricao')).Font.Size := 9;

        TListItemText(Objects.FindDrawable('lblEvent1')).Text := LIgnicaoStatus;
        TListItemText(Objects.FindDrawable('lblEvent1')).Font.Size := 9;

        TListItemText(Objects.FindDrawable('lblEvent2')).Text := LBateriaStatus;
        TListItemText(Objects.FindDrawable('lblEvent2')).Font.Size := 9;
      end;

      DM.FPositionLast.Next;
    end;

  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  LDir: string;
  LFile: string;
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

  Application.ProcessMessages;

  tbcMain.ActiveTab := tbiLogin;

  FPanelMap := TPanel.Create(Self);
  FPanelMap.Parent := lytMapa;
  FPanelMap.Align := TAlignLayout.Client;

  Map := TTMSFNCGoogleMaps.Create(lytMapa);
  Map.APIKey := cGoogleMapsWebAPI;

  Map.BeginUpdate;

  Map.Options.MapTypeID := TTMSFNCGoogleMapsMapTypeID.gmtDefault;
  Map.Options.Locale := 'pt-BR';
  Map.ReInitialize;

  Map.SetCenterCoordinate(cLat, cLng);

  Map.Options.DefaultLatitude := cLat;
  Map.Options.DefaultLongitude := cLng;
  Map.Options.DefaultZoomLevel := cZoom;

  Map.Options.ShowMapTypeControl := False;
  Map.Options.ShowBicycling := False;
  Map.Options.ShowStreetViewControl := False;
  Map.Options.ShowScaleControl := False;
  Map.Options.ShowTraffic := False;
  Map.Options.Tilt := 68;

  Map.OnMarkerClick := doMarkerClick;
  Map.OnOverlayViewClick := doOverlayViewClick;

  Map.Align := TAlignLayout.Client;
  Map.Parent := FPanelMap;

  Map.EndUpdate;

  tbcMain.TabPosition := TTabPosition.None;

  { todo -o@WOS83:Esconde a Lista de Veículos }
  lytListaVeiculos.Visible := False;

  {$IFDEF MSWINDOWS}
  // LFile := 'file://' + StringReplace(ExtractFilePath(ParamStr(0)), '\', '/', [rfReplaceAll]);
  FImageCarOn48 := cImageUrlCarOn48;
  FImageCarOff48 := cImageUrlCarOff48;
  {$ENDIF}
  {$IFDEF ANDROID}
  LFile := 'file://' + TPath.GetDocumentsPath;

  FImageCarOn48 := TPath.Combine(LFile, cImageCarOn48);
  if not FileExists(FImageCarOn48) then
    FImageCarOn48 := cImageUrlCarOn48;

  FImageCarOff48 := TPath.Combine(LFile, cImageCarOff48);
  if not FileExists(FImageCarOff48) then
    FImageCarOff48 := cImageUrlCarOff48;

  {$ENDIF}
  FTimerPositionLast := TTimer.Create(Self);
  FTimerPositionLast.Interval := 10000;
  FTimerPositionLast.Enabled := False;
  FTimerPositionLast.OnTimer := doUpdatePositionLast;

  FTimerDrawOnMap := TTimer.Create(Self);
  FTimerDrawOnMap.Interval := 20000;
  FTimerDrawOnMap.Enabled := False;
  FTimerDrawOnMap.OnTimer := doUpdateDrawOnMap;

  edtLoginNome.Text := 'william';
  edtLoginSenha.Text := '#h#p0te5YZ';
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  FreeAndNil(Map);
  FreeAndNil(FPanelMap);
  {$ELSE}
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

procedure TFrmMain.lstvListaVeiculosItemClickEx(

   const Sender: TObject; ItemIndex: Integer; //

const LocalClickPos: TPointF;

const ItemObject: TListItemDrawable);
begin
  Map.Opacity := 1;
  Map.Visible := True;
  lytListaVeiculos.SendToBack;
  lytListaVeiculos.Visible := False;
end;

end.
