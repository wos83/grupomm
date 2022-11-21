import { Socket } from 'net';

import { Device } from '../interfaces/Device';

const deviceList: Array<Device> = [];

export const addDeviceList = (
  connection: Socket,
  { deviceId }: Device,
): void => {
  const cleanDeviceId = deviceId.replace('\r', '');
  const objIndex = deviceList.findIndex(
    ({ deviceId: id }) => id === cleanDeviceId,
  );

  if (deviceList[objIndex]?.connection) deviceList.splice(objIndex, 1);

  deviceList.push({ deviceId: cleanDeviceId, connection });
};

export const removeDevice = (connection: Socket): void => {
  const objIndex = deviceList.findIndex(
    ({ connection: conn }) => conn === connection,
  );

  deviceList.splice(objIndex, 1);
};

export const findDeviceConnection = (deviceId: string): Socket | undefined => {
  console.warn({ deviceList });

  return deviceList.find(({ deviceId: id }) => id === deviceId)?.connection;
};
