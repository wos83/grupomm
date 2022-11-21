import { SplittedPosition, TreatedBits } from '../interfaces/Package';
import Position from '../models/Position';
import PositionRepository from '../repositories/PositionRepository';

class PositionService {
  execute = async (
    position: SplittedPosition | Record<string, string>,
  ): Promise<Position> => {
    const typedPosition = this.typingPosition(position);

    return PositionRepository.getRepository().savePosition(typedPosition);
  };

  typingPosition = (
    data: SplittedPosition | Record<string, string>,
  ): Position => {
    const treatedBits: TreatedBits = {
      ignition: Boolean(+data.ignition),
      inputOne: Boolean(+data.inputOne),
      inputTwo: Boolean(+data.inputTwo),
      inputThree: Boolean(+data.inputThree),
      outputOne: Boolean(+data.outputOne),
      outputTwo: Boolean(+data.outputTwo),
    };

    return {
      backupBattery: data.backupBattery,
      backupBatteryPercent: data.backupBatteryPercent,
      deviceId: data.deviceId,
      fwVersion: data.fwVersion,
      datetime: new Date(`${data.date} ${data.time}`),
      systemDate: new Date(),
      latitude: data.latitude,
      longitude: data.longitude,
      speed: Math.floor(+data.speed),
      course: Math.floor(+data.course),
      odometer: data.odometer,
      satellite: +data.satellite,
      mainBattery: data.mainBattery,
      gpsFix: data.gpsFix === 'A',
      ...treatedBits,
    };
  };
}

export default new PositionService();
