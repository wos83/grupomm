export interface IDataPosition {
  latitude: number;
  longitude: number;
  speed: number;
  licensePlate: string;
  label: string;
  date: string;
  ignition: boolean;
  address: string;
  iconType: string;
  gpsFix: boolean;
  mainBattery: string;
  backupBattery: { voltage: string; percent: number };
  odometer: string;
  horimeter: string;
  output1: boolean;
  output2: boolean;
}
