unit uConsts;

interface

uses
  System.SysUtils,
  System.IOUtils;

const
  { todo -o@WOS83 -cGoogle Maps:Google Maps API (Web)
    Criada em 15/11/2022 - 16:58:16
    Email: grupomm.dev@gmail.com }
  cGoogleMapsWebAPI = 'AIzaSyB8Nc2NQIBhkNwj1-50zbPKUmIqxYq5BXY';

  cConnDef = 'FDConnectionDefs.ini';

  cImageCarOn48 = 'images/car-on-48.png';
  cImageCarOff48 = 'images/car-off-48.png';

  cImageUrlCarOn48 = 'http://i.imgur.com/Hd62TQK.png';
  cImageUrlCarOff48 = 'http://i.imgur.com/KCYhik5.png';

  cIgnitionColor = $FF344050;
  cIgnitionOnColor = $FF196F3D;
  cIgnitionOffColor = $FFC0392B;

  cIgnitionOnText = '🟢 Ligado';
  cIgnitionOffText = '🔴 Desligado';

  cBatteryOnColor = $FF196F3D;
  cBatteryOffColor = $FFC0392B;

  cBatteryOnText = '🟢 Conectada';
  cBatteryOffText = '🔴 Desconectada';

implementation

end.
