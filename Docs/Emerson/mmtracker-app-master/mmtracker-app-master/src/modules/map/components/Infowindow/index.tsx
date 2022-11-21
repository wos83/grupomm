import React from 'react';
import FontAwesome5 from 'react-native-vector-icons/FontAwesome5';

import { IDataPosition } from '../../../../interfaces/positions';
import IWItem from './IWItem';
import {
  AddressContent,
  Container,
  IconsContent,
  InfoAddress,
  SubTitle,
  Title,
} from './styles';

type IInfowindowProps = {
  item: IDataPosition;
};

const Infowindow = ({ item }: IInfowindowProps): JSX.Element => {
  const {
    address,
    date,
    gpsFix,
    licensePlate,
    mainBattery,
    odometer,
    output1,
    output2,
    speed,
  } = item;

  const topIcons = [
    {
      icon: 'tachometer-alt',
      value: `${speed} Km/h`,
    },
    {
      icon: 'road',
      value: `${odometer} m`,
      fontSize: 10,
    },
    {
      icon: 'car-battery',
      value: `${mainBattery} V`,
    },
  ];

  const bottomIcons = [
    {
      icon: 'lock',
      value: output1 ? 'Bloqueado' : 'Desbloqueado',
      fontSize: 12,
    },
    {
      icon: 'volume-up',
      value: output2 ? 'Sirene ativa' : 'Sirene desativada',
      fontSize: 12,
    },
    {
      icon: 'satellite',
      value: gpsFix ? 'GPS Fixo' : 'GPS não fixo',
      fontSize: 12,
    },
  ];

  return (
    <Container>
      <Title>{licensePlate}</Title>
      <SubTitle>{date}</SubTitle>
      <IconsContent>
        {topIcons.map((icons, key) => (
          <IWItem {...icons} key={key} />
        ))}
      </IconsContent>
      <IconsContent>
        {bottomIcons.map((icons, key) => (
          <IWItem {...icons} key={key} />
        ))}
      </IconsContent>
      <IconsContent>
        <AddressContent>
          <FontAwesome5 name="map-marker-alt" color="#1071E0" size={28} />
          <InfoAddress>{address}</InfoAddress>
        </AddressContent>
      </IconsContent>
    </Container>
  );
};

export default Infowindow;
