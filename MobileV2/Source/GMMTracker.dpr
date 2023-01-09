program GMMTracker;

uses
  {$IFDEF MSWINDOWS}
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  madLinkDisAsm,
  {$ENDIF }
  System.Classes,
  System.IOUtils,
  System.StartUpCopy,
  System.SysUtils,
  FMX.Forms,
  FMX.Memo,
  uConsts in 'uConsts.pas',
  uLibrary in 'uLibrary.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uLogin in 'uLogin.pas',
  uUser in 'uUser.pas',
  uGeoInfo in 'uGeoInfo.pas',
  uPositionLast in 'uPositionLast.pas',
  uLog in 'uLog.pas',
  uPositionHistory in 'uPositionHistory.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
  {$IFDEF MSWINDOWS}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  {$ENDIF}
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;

end.
