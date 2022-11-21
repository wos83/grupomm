import { IHistoricCommands } from '../../../../../interfaces/commands';
import { IGridColumns } from '../../../../../interfaces/positions';
import ColumnDate from '../dateColumn';
import { Td, Tr } from '../styles';

function Row({
  data,
  index,
  tableColumns,
}: {
  data: IHistoricCommands;
  index: number;
  tableColumns: Array<IGridColumns> | undefined;
}): JSX.Element {
  const getTreatmentData = (path: string) => {
    const components = {
      date: <ColumnDate data={data} path={path} />,
    };

    const rule = components[path as keyof typeof components];

    return rule || data[path as keyof typeof data];
  };

  return (
    <div>
      {tableColumns && tableColumns.length && (
        <Tr striped={index % 2}>
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
