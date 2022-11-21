import Tooltip from '../../../../../components/tooltip';
import {
  IBackupBattery,
  IDataPosition,
} from '../../../../../interfaces/positions';
import {
  batteryEmpty,
  batteryFull,
  batteryMiddle,
  batteryOneQuarter,
  batteryThreeQuarter,
  batteryWarning,
} from './icons-imports';
import { Content } from './styles';

function ColumnBackupBattery({
  data,
  path,
}: {
  data: IDataPosition;
  path: string;
}): JSX.Element {
  const backupBattery = data[
    path as keyof typeof data
  ] as unknown as IBackupBattery;

  const getImageByPercentOfBattery = (percent: number) => {
    let component;

    const images = {
      '0': <img src={batteryEmpty} alt="empty-battery" />,
      '1-20': <img src={batteryWarning} alt="warning-battery" />,
      '21-44': <img src={batteryOneQuarter} alt="one-quarter-battery" />,
      '45-55': <img src={batteryMiddle} alt="middle-battery" />,
      '56-99': <img src={batteryThreeQuarter} alt="three-quarter-battery" />,
      '100': <img src={batteryFull} alt="full-battery" />,
    };

    Object.keys(images).some((k) => {
      const part = k.split('-');
      if (percent >= +part[0] && percent <= (+part[1] || +part[0])) {
        component = images[k as keyof typeof images];
        return true;
      }
      return false;
    });

    return component;
  };

  return (
    <Content percentBattery={backupBattery.percent}>
      <Tooltip label={`${backupBattery.voltage} v`}>
        <div>
          {getImageByPercentOfBattery(backupBattery.percent)}
          {`${backupBattery.percent}%`}
        </div>
      </Tooltip>
    </Content>
  );
}

export default ColumnBackupBattery;
