import { Fragment, useState } from 'react';

import { Tr as TrChakra } from '@chakra-ui/react';
import caretLine from '@iconify/icons-clarity/caret-line';
import { Icon } from '@iconify/react';

import {
  IDataPosition,
  IGridColumns,
  ILatLng,
} from '../../../../../interfaces/positions';
import ColumnBackupBattery from '../backupBatteryColumn';
import CollapseRow from '../collapseRow';
import ColumnDate from '../dateColumn';
import { Td, Tr } from '../styles';
import AddressColumn from '../addressColumn';

function Row({
  data,
  index,
  tableColumns,
  setZoomLatLng,
}: {
  data: IDataPosition;
  index: number;
  tableColumns: Array<IGridColumns> | undefined;
  setZoomLatLng: (latLng: ILatLng) => void;
}): JSX.Element {
  const [isCollapse, setIsCollapse] = useState(false);

  const handleClickCollapse = async () => {
    setZoomLatLng({ lat: data.latitude, lng: data.longitude });
    setIsCollapse(!isCollapse);
  };

  const getTreatmentData = (path: string) => {
    const components = {
      address: <AddressColumn data={data} path={path} />,
      backupBattery: <ColumnBackupBattery data={data} path={path} />,
      date: <ColumnDate data={data} path={path} />,
    };

    const rule = components[path as keyof typeof components];

    return rule || data[path as keyof typeof data];
  };

  return (
    <div>
      {tableColumns && tableColumns.length && (
        <>
          <Tr
            onClick={handleClickCollapse}
            cursor="pointer"
            striped={index % 2}>
            {tableColumns.map(({ path }, idx) => (
              <Fragment key={path}>
                {!idx && (
                  <Td firstElement isCollapse={isCollapse} padding={16}>
                    <Icon icon={caretLine} width={16} height={16} />
                  </Td>
                )}
                <Td padding={16}>{getTreatmentData(path)}</Td>
              </Fragment>
            ))}
          </Tr>
          <TrChakra>
            <Td collapseComponent colSpan={tableColumns.length + 1} padding={0}>
              <CollapseRow isOpen={isCollapse} />
            </Td>
          </TrChakra>
        </>
      )}
    </div>
  );
}

export default Row;
