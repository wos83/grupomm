import { useState } from 'react';

import {
  IDataPosition,
  IGridColumns,
  ILatLng,
} from '../../../../../interfaces/positions';
import AddressColumn from '../../../../map/components/grid/addressColumn';
import ColumnBackupBattery from '../../../../map/components/grid/backupBatteryColumn';
import ColumnDate from '../../../../map/components/grid/dateColumn';
import { Td, Tr } from '../styles';

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
        <Tr onClick={handleClickCollapse} cursor="pointer" striped={index % 2}>
          {tableColumns.map(({ path }) => (
            <Td key={path} padding={16}>
              {getTreatmentData(path)}
            </Td>
          ))}
        </Tr>
      )}
    </div>
  );
}

export default Row;
