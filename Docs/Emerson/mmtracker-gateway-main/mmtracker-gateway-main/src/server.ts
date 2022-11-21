import 'dotenv/config';
import { Socket, createServer } from 'net';
import cron from 'node-cron';

import CreateOrGetConnection from './config/CreateOrGetConnection';
import { addDeviceList, removeDevice } from './controllers/DeviceController';
import packageHandling from './controllers/PackageController';
import { Device } from './interfaces/Device';
import CommandService from './services/CommandService';
import { getDevice } from './utils/device';

CreateOrGetConnection();

const server = createServer((connection: Socket) => {
  console.warn('new connection');

  let connectedDevice: Device = { deviceId: '', manufacturer: '' };

  connection.on('data', async (data: Buffer) => {
    console.warn(data.toString());

    const currentDevice = getDevice(data);

    packageHandling(currentDevice, data);

    if (!connectedDevice.deviceId) {
      addDeviceList(connection, currentDevice);
      connectedDevice = currentDevice;
    }
  });

  connection.on('end', () => {
    console.warn('connection closed');

    removeDevice(connection);
    connection.destroy();
  });
});

cron.schedule('*/15 * * * * *', () => CommandService.commandsToDevice());

server.on('error', (err) => {
  console.error(err);
});

server.listen(2456);

//  ST300STT;007732942;40;318;20210723;00:23:10;2c9323;-23.329177;-046.725253;000.000;330.47;17;1;17909846;12.86;000000;1;0016;048935;4.1;1
