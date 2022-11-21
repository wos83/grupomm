import { Socket } from 'net';

export interface Device {
  deviceId: string;
  connection?: Socket;
  manufacturer?: string;
}

export interface DeviceProperties {
  manufacturer: string;
  separator: string;
}
