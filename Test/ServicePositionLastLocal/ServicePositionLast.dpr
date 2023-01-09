program ServicePositionLast;

uses
  System.Android.ServiceApplication,
  uDM in 'uDM.pas' {DM: TAndroidService};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
