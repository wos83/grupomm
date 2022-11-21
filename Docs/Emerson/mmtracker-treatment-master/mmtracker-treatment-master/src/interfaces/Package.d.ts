export interface Package {
  pack: string;
  manufacturer: string;
}

export interface TreatedBits {
  ignition: boolean;
  inputOne: boolean;
  inputTwo: boolean;
  inputThree: boolean;
  outputOne: boolean;
  outputTwo: boolean;
}

export interface SplittedPosition {
  deviceId: string;
  fwVersion: string;
  date: string;
  gpsFix: string;
  time: string;
  latitude: string;
  longitude: string;
  speed: string;
  course: string;
  odometer: string;
  satellite: string;
  mainBattery: string;
  backupBattery: string;
  backupBatteryPercent: string;
  ignition: string;
  inputOne: string;
  inputTwo: string;
  inputThree: string;
  outputOne: string;
  outputTwo: string;
}

export interface SplittedCommand {
  deviceId: string;
  data: string;
  manufacturer: string;
  commandName: string;
  sentDate: string;
  requestDate: string;
  confirmDate: string;
}

export interface SplittedEvent extends SplittedPosition {
  evtId: number;
  hourimeter: string;
  isRealMessage: boolean;
}
