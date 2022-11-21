import { Tbody, Thead } from '@chakra-ui/react';

import {
  IDataPosition,
  IGridColumns,
  ILatLng,
} from '../../../../interfaces/positions';
import Row from './row';
import { Container, Table, Th, Tr } from './styles';

type IGridProps = {
  tableColumns: Array<IGridColumns> | undefined;
  dataPositions: Array<IDataPosition> | undefined;
  setZoomToLatLng: (latLng: ILatLng) => void;
};

function Grid({
  tableColumns,
  dataPositions,
  setZoomToLatLng,
}: IGridProps): JSX.Element {
  return (
    <Container>
      <Table width="100%">
        <Thead>
          <Tr>
            {tableColumns?.map(({ path, name }) => (
              <Th key={path}>{name}</Th>
            ))}
          </Tr>
        </Thead>
        <Tbody>
          {dataPositions?.map((data, index) => (
            <Row
              key={index}
              data={data}
              index={index}
              tableColumns={tableColumns}
              setZoomLatLng={setZoomToLatLng}
            />
          ))}
        </Tbody>
      </Table>
    </Container>
  );
}

export default Grid;
