import L from 'leaflet';
import { useEffect } from 'react';
import { MapContainer, TileLayer, Marker, useMap } from 'react-leaflet';
import Fullscreen from 'react-leaflet-fullscreen-plugin';

import iconCar from '../../../../assets/img/vehicles/icon_car.png';
import { IDataPosition, ILatLng } from '../../../../interfaces/positions';
import Infowindow from '../infoWindow';

type IMapProps = {
  dataPositions: Array<IDataPosition> | undefined;
  zoomToLatLng: ILatLng | undefined;
};

type IMapInteractionProps = {
  latLng: ILatLng;
};

function MapContent({
  dataPositions = [],
  zoomToLatLng = { lat: -23.329134, lng: -46.725234 },
}: IMapProps): JSX.Element {
  function MapInteraction({ latLng }: IMapInteractionProps) {
    const map = useMap();

    useEffect(() => {
      map.flyTo(latLng, 18);
    }, [map, latLng]);

    return null;
  }

  return (
    <MapContainer center={zoomToLatLng} zoom={16} id="map-container">
      <TileLayer
        url="https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png"
        attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      />
      <MapInteraction latLng={zoomToLatLng} />
      <Fullscreen position="topleft" />
      {dataPositions.map((item, key) => {
        const vehicleIcon = new L.Icon({
          iconUrl: iconCar,
          iconRetinaUrl: iconCar,
          popupAnchor: [-3, -40],
          iconSize: new L.Point(80, 80),
        });

        return (
          <Marker
            key={key}
            icon={vehicleIcon}
            position={[item.latitude, item.longitude]}>
            <Infowindow {...item} key={key} />
          </Marker>
        );
      })}
    </MapContainer>
  );
}

export default MapContent;
