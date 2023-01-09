program ServicePositionLast;

uses
  System.Android.ServiceApplication,
  uDM in 'uDM.pas' {DM: TAndroidService},
  uConsts in '..\..\MobileV2\Source\uConsts.pas',
  uUser in '..\..\MobileV2\Source\uUser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
