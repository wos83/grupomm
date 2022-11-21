import { SplittedEvent } from '../interfaces/Package';
import OpenEvent from '../models/OpenEvent';
import EventRepository from '../repositories/EventRepository';

class EventService {
  execute = async (
    command: SplittedEvent | Record<string, string>,
    type: string | undefined,
  ): Promise<OpenEvent> => {
    const typingEvent = this.typingEvent(command, type);

    return EventRepository.getRepository().saveEvent(typingEvent);
  };

  typingEvent = (
    data: SplittedEvent | Record<string, string>,
    type: string | undefined,
  ): OpenEvent => {
    return {
      backupBattery: data.backupBattery,
      course: Math.floor(+data.course),
      datetime: new Date(`${data.date} ${data.time}`),
      deviceId: data.deviceId,
      evtId: +data.evtId,
      fwVersion: data.fwVersion,
      gpsFix: Boolean(+data.gpsFix),
      hourimeter: data.hourimeter,
      ignition: Boolean(+data.ignition),
      inputOne: Boolean(+data.inputOne),
      inputTwo: Boolean(+data.inputTwo),
      inputThree: Boolean(+data.inputThree),
      isRealMessage: Boolean(+data.isRealMessage),
      latitude: data.latitude,
      longitude: data.longitude,
      mainBattery: data.mainBattery,
      odometer: data.odometer,
      outputOne: Boolean(+data.outputOne),
      outputTwo: Boolean(+data.outputTwo),
      satellite: +data.satellite,
      speed: Math.floor(+data.speed),
      systemDate: new Date(),
      type,
    };
  };
}

export default new EventService();
