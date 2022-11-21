import { Fragment, useState } from 'react';

import { Tbody, Thead } from '@chakra-ui/react';
import caretLine from '@iconify/icons-clarity/caret-line';
import maxLine from '@iconify/icons-clarity/window-max-line';
import minusLine from '@iconify/icons-clarity/window-min-line';

import Button from '../../../../components/button';
import FilterButton from '../../../../components/filterButton';
import { LARGE_ICON_SIZE } from '../../../../constants';
import {
  IDataPosition,
  IGridColumns,
  ILatLng,
} from '../../../../interfaces/positions';
import Row from './row';
import {
  Container,
  ContentButtons,
  ContentGrid,
  ExpandButton,
  MinimizedButton,
  Table,
  Th,
  Tr,
} from './styles';

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
  const [isGridExpand, setIsGridExpand] = useState(false);
  const [isGridMinimized, setIsGridMinimized] = useState(false);

  const handleClickExpand = (e: React.MouseEvent<HTMLElement>) => {
    if (isGridMinimized) {
      e.preventDefault();
      return;
    }

    setIsGridExpand((current) => !current);
    setIsGridMinimized(false);
  };

  const handleClickMinimize = () => {
    setIsGridMinimized((current) => !current);
    setIsGridExpand(false);
  };

  return (
    <>
      <ContentButtons>
        <FilterButton />
        <ExpandButton onClick={handleClickExpand} gridExpanded={isGridExpand}>
          <Button
            disabled={isGridMinimized}
            icon={caretLine}
            iconSize={LARGE_ICON_SIZE}
            padding={5}
          />
        </ExpandButton>
        <MinimizedButton onClick={handleClickMinimize}>
          <Button
            icon={!isGridMinimized ? minusLine : maxLine}
            iconSize={LARGE_ICON_SIZE}
            padding={5}
          />
        </MinimizedButton>
      </ContentButtons>
      <Container>
        <ContentGrid
          gridExpanded={isGridExpand}
          gridMinimized={isGridMinimized}>
          <Table width="100%">
            <Thead>
              <Tr>
                {tableColumns?.map(({ path, name }, idx) => (
                  <Fragment key={path}>
                    {!idx && <Th />}
                    <Th>{name}</Th>
                  </Fragment>
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
        </ContentGrid>
      </Container>
    </>
  );
}

export default Grid;
