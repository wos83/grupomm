import { Socket } from 'net';

import { Device, DeviceProperties } from '../interfaces/Device';

export const getDeviceProperties = (deviceHeader: string): DeviceProperties => {
  const trackerModel = {
    '*E': { separator: ',', manufacturer: 'E3' },
    xx: { separator: ',', manufacturer: 'GT06' },
    SA: { separator: ';', manufacturer: 'ST' },
    ST: { separator: ';', manufacturer: 'ST' },
    default: { separator: '', manufacturer: '' },
  };

  return (
    trackerModel[deviceHeader as keyof typeof trackerModel] ||
    trackerModel.default
  );
};

export const getDevice = (data: Buffer): Device => {
  const convertedData = data.toString();

  const { separator, manufacturer } = getDeviceProperties(
    convertedData.substr(0, 2),
  );

  const deviceId = convertedData.split(separator)[1];
  const cleanDeviceId = deviceId.replace('\r', '');
  console.warn({ cleanDeviceId });

  return { deviceId: cleanDeviceId, manufacturer };
};

export const sendToDevice = (data: string, connection: Socket): void => {
  console.warn('command to device:', data);
  connection.write(Buffer.from(data));
};
