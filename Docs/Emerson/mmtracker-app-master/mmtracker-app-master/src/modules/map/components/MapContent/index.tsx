import React from 'react';
import { Dimensions } from 'react-native';
import MapView, { Marker, Callout } from 'react-native-maps';

import truckIconOn from '../../../../assets/images/icons/caminhao_green.png';
import truckIconOff from '../../../../assets/images/icons/caminhao_red.png';
import carIconOn from '../../../../assets/images/icons/carro_green.png';
import carIconOff from '../../../../assets/images/icons/carro_red.png';
import motoIconOn from '../../../../assets/images/icons/moto_green.png';
import motoIconOff from '../../../../assets/images/icons/moto_red.png';
import { IDataPosition } from '../../../../interfaces/positions';
import Infowindow from '../Infowindow';

const { width, height } = Dimensions.get('window');

const ASPECT_RATIO = width / height;
const LATITUDE = -15;
const LONGITUDE = -45;
const LATITUDE_DELTA = 15;
const LONGITUDE_DELTA = LATITUDE_DELTA * ASPECT_RATIO;

type IMapProps = {
  dataPositions: Array<IDataPosition>;
};

const MapContent = ({ dataPositions = [] }: IMapProps): JSX.Element => {
  const vehicleIcon = (iconType: string, ignition: boolean) => {
    switch (iconType) {
      case 'moto':
        return ignition ? motoIconOn : motoIconOff;
      case 'truck':
        return ignition ? truckIconOn : truckIconOff;
      case 'car':
      default:
        return ignition ? carIconOn : carIconOff;
    }
  };

  return (
    <MapView
      style={{
        width: '100%',
        height: '100%',
      }}
      initialRegion={{
        latitude: LATITUDE,
        longitude: LONGITUDE,
        latitudeDelta: LATITUDE_DELTA,
        longitudeDelta: LONGITUDE_DELTA,
      }}
      initialCamera={{
        center: {
          latitude: -23.329134,
          longitude: -46.725234,
        },
        heading: 0,
        pitch: 0,
        altitude: 0,
        zoom: 13,
      }}
      // customMapStyle={silver}
      rotateEnabled={false}>
      {dataPositions.map((marker) => (
        <Marker
          key={marker.latitude}
          image={vehicleIcon(marker.iconType, marker.ignition)}
          coordinate={{
            latitude: marker.latitude,
            longitude: marker.longitude,
          }}
          title={marker.licensePlate}
          description={marker.address}
          centerOffset={{ x: -42, y: -60 }}
          anchor={{ x: 0.5, y: 0.5 }}>
          <Callout tooltip>
            <Infowindow item={marker} />
          </Callout>
        </Marker>
      ))}
    </MapView>
  );
};

export default MapContent;
