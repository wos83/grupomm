unit uGeoInfo;

interface

uses
  System.Sensors;

type
  TGeoInfo = class
  public
    AdminArea: string;
    CountryCode: string;
    CountryName: string;
    FeatureName: string;
    Locality: string;
    PostalCode: string;
    SubAdminArea: string;
    SubLocality: string;
    SubThoroughfare: string;
    Thoroughfare: string;

    procedure OnGeocodeReverseEvent(const Address: TCivicAddress);
  end;

var
  FGeoInfo: TGeoInfo;
  FGeocoder: TGeocoder;

implementation

procedure TGeoInfo.OnGeocodeReverseEvent(const Address: TCivicAddress);
begin
  FGeoInfo.AdminArea := Address.AdminArea;
  FGeoInfo.CountryCode := Address.CountryCode;
  FGeoInfo.CountryName := Address.CountryName;
  FGeoInfo.FeatureName := Address.FeatureName;
  FGeoInfo.Locality := Address.Locality;
  FGeoInfo.PostalCode := Address.PostalCode;
  FGeoInfo.SubAdminArea := Address.SubAdminArea;
  FGeoInfo.SubLocality := Address.SubLocality;
  FGeoInfo.SubThoroughfare := Address.SubThoroughfare;
  FGeoInfo.Thoroughfare := Address.Thoroughfare;
end;

end.
