export interface IBackupBattery {
  voltage: string;
  percent: number;
}

export interface IDataPosition {
  deviceId: string;
  latitude: number;
  longitude: number;
  speed: number;
  odometer: string;
  mainBattery: string;
  backupBattery: IBackupBattery;
  output1: boolean;
  output2: boolean;
  gpsFix: boolean;
  licensePlate: string;
  date: string;
  ignition: boolean;
  address: string;
}

export interface IGridColumns {
  path: string;
  name: string;
}

export interface ILatLng {
  lat: number;
  lng: number;
}
