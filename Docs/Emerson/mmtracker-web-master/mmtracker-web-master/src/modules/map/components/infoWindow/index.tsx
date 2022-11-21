import mapMarkerIcon from '@iconify/icons-clarity/map-marker-line';
import carBatteryIcon from '@iconify/icons-mdi/car-battery';
import lockOpenIcon from '@iconify/icons-mdi/lock-open';
import odometerIcon from '@iconify/icons-mdi/road-variant';
import satelliteIcon from '@iconify/icons-mdi/satellite-variant';
import speedometerIcon from '@iconify/icons-mdi/speedometer';
import sirenIcon from '@iconify/icons-mdi/volume-medium';

import { IDataPosition } from '../../../../interfaces/positions';
import IWItem from './item';
import {
  Container,
  Title,
  SubTitle,
  IconsContent,
  AddressContent,
  InfoIcon,
  InfoAddress,
} from './styles';

function Infowindow(item: IDataPosition): JSX.Element {
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
      icon: speedometerIcon,
      value: `${speed} Km/h`,
    },
    {
      icon: odometerIcon,
      value: `${odometer} m`,
      fontSize: 10,
    },
    {
      icon: carBatteryIcon,
      value: `${mainBattery} V`,
    },
  ];

  const bottomIcons = [
    {
      icon: lockOpenIcon,
      value: output1 ? 'Bloqueado' : 'Desbloqueado',
      fontSize: 12,
    },
    {
      icon: sirenIcon,
      value: output2 ? 'Sirene ativa' : 'Sirene desativada',
      fontSize: 12,
    },
    {
      icon: satelliteIcon,
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
          <InfoIcon icon={mapMarkerIcon} color="#1071E0" width={40} />
          <InfoAddress>{address}</InfoAddress>
        </AddressContent>
      </IconsContent>
    </Container>
  );
}

export default Infowindow;
