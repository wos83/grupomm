import { useEffect, useState } from 'react';

import {
  IDataPosition,
  IGridColumns,
  ILatLng,
} from '../../interfaces/positions';
import VehicleService from '../../services/vehicles';
import Grid from './components/grid';
import MapContent from './components/mapContent';
import { Container } from './styles';

function Map(): JSX.Element {
  const [gridTableColumns, setGridTableColumns] =
    useState<Array<IGridColumns>>();
  const [vehiclesData, setVehiclesData] = useState<Array<IDataPosition>>();
  const [zoomToLatLng, setZoomToLatLng] = useState<ILatLng | undefined>(
    undefined,
  );

  useEffect(() => {
    (async () => {
      const { data } = await VehicleService.getVehiclePositions();

      setVehiclesData(data[0].data);
      setGridTableColumns(data[0].tableColumns);
    })();
  }, []);

  return (
    <Container>
      <MapContent dataPositions={vehiclesData} zoomToLatLng={zoomToLatLng} />
      <Grid
        tableColumns={gridTableColumns}
        dataPositions={vehiclesData}
        setZoomToLatLng={setZoomToLatLng}
      />
    </Container>
  );
}

export default Map;
