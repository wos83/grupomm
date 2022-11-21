import { format, formatDistanceToNowStrict } from 'date-fns';
import { ptBR } from 'date-fns/locale';
import { useTheme } from 'styled-components';

import { IHistoricCommands } from '../../../../../interfaces/commands';
import { IBackupBattery } from '../../../../../interfaces/positions';
import { Tag } from './styles';

function ColumnDate({
  data,
  path,
}: {
  data: IHistoricCommands;
  path: string;
}): JSX.Element {
  const theme = useTheme();

  const getTimeFromLastPositionDate = (
    date: string | number | boolean | IBackupBattery,
  ) =>
    `há ${formatDistanceToNowStrict(new Date(date as string), {
      locale: ptBR,
    })}`;

  const formatDate = (date: string | number | boolean | IBackupBattery) =>
    format(new Date(date as string), 'dd/MM/yyyy kk:mm');

  const getColorByTimeOfLastPosition = (
    date: string | number | boolean | IBackupBattery,
  ) => {
    const dateString = date as string;

    if (dateString.includes('minutos')) return theme.colors.success;

    if (dateString.includes('horas')) return theme.colors.notification;

    return theme.colors.alarm;
  };

  return (
    <>
      {formatDate(data[path as keyof typeof data])}
      <Tag
        color={getColorByTimeOfLastPosition(
          getTimeFromLastPositionDate(data[path as keyof typeof data]),
        )}>
        {getTimeFromLastPositionDate(data[path as keyof typeof data])}
      </Tag>
    </>
  );
}

export default ColumnDate;
