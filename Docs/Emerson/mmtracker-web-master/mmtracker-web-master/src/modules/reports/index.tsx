import { useCallback, useEffect, useRef, useState } from 'react';

import caretLine from '@iconify/icons-clarity/caret-line';

import Button from '../../components/button';
import { LARGE_ICON_SIZE } from '../../constants';
import {
  IDataPosition,
  IGridColumns,
  ILatLng,
} from '../../interfaces/positions';
import VehicleService from '../../services/vehicles';
import Filters from './components/filters';
import Grid from './components/grid';
import MapContent from './components/mapContent';
import { Container, ContentGrid, ContentMap, ExpandGrid } from './styles';

function Reports(): JSX.Element {
  const containerRef = useRef<HTMLDivElement>(null);

  const [gridExpanded, setGridExpanded] = useState(false);
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

  const handleExpand = useCallback(() => {
    setGridExpanded((current) => !current);
  }, []);

  return (
    <Container>
      <Filters />
      <ContentGrid ref={containerRef} expanded={gridExpanded}>
        <Grid
          tableColumns={gridTableColumns}
          dataPositions={vehiclesData}
          setZoomToLatLng={setZoomToLatLng}
        />
        <ExpandGrid expanded={gridExpanded}>
          <Button
            onClick={handleExpand}
            icon={caretLine}
            iconSize={LARGE_ICON_SIZE}
            padding={5}
          />
        </ExpandGrid>
      </ContentGrid>
      <ContentMap gridExpanded={gridExpanded}>
        <MapContent dataPositions={vehiclesData} zoomToLatLng={zoomToLatLng} />
      </ContentMap>
    </Container>
  );
}

export default Reports;
