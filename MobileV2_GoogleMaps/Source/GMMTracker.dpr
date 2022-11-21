program GMMTracker;

uses
  {$IFDEF MSWINDOWS}
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  {$ENDIF}
  System.StartUpCopy,
  System.IOUtils,
  FMX.Forms,
  uConsts in 'uConsts.pas',
  uLibrary in 'uLibrary.pas',
  uDM in 'uDM.pas' {DM: TDataModule} ,
  uFrmMain in 'uFrmMain.pas' {FrmMain};

{$R *.res}

var
  LFile: string;

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  {$IFDEF ANDROID}
  // IdOpenSSLSetLibPath(TPath.GetDocumentsPath);
  // LoadOpenSSLLibrary;
  {$ENDIF}
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;

end.
