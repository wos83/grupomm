import { useState } from 'react';

import Input from '../input';
import {
  Container,
  ContentVehicles,
  VehicleCard,
  VehicleFilter,
  List,
} from './styles';

interface IVehicles {
  date: string;
  plate: string;
}

interface IVehicleList {
  vehicles: Array<IVehicles>;
  maxHeight?: number;
}

function VehicleList({ vehicles, maxHeight }: IVehicleList): JSX.Element {
  const [selectedVehicle, setSelectedVehicle] = useState<number>();

  return (
    <Container>
      <h1>Veículos:</h1>
      <ContentVehicles>
        <div>
          <VehicleFilter>
            <Input
              backgroundColor="gray.200"
              borderRadius="xl"
              placeholder="Filtrar"
              size="xs"
            />
          </VehicleFilter>
          <List maxHeight={maxHeight}>
            {vehicles.map((vehicle, index) => (
              <VehicleCard
                key={index}
                onClick={() => setSelectedVehicle(index)}
                selected={index === selectedVehicle}>
                <strong>{vehicle.plate}</strong>
                <span>{vehicle.date}</span>
              </VehicleCard>
            ))}
          </List>
        </div>
      </ContentVehicles>
    </Container>
  );
}

export default VehicleList;
