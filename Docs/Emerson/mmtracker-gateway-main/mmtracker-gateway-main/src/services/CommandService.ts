import { findDeviceConnection } from '../controllers/DeviceController';
import SendCommandsRepository from '../repositories/SendCommandsRepository';
import { sendToDevice } from '../utils/device';

class CommandService {
  commandsToDevice = async () => {
    const commandList =
      await SendCommandsRepository.getRepository().getCommands();

    console.warn({ commandList });

    commandList.forEach(({ data, deviceId, id }) => {
      const deviceConnection = findDeviceConnection(deviceId);
      console.warn({ deviceConnection });

      if (deviceConnection) {
        sendToDevice(data, deviceConnection);

        SendCommandsRepository.getRepository().updateSentCommand(id);
      }
    });
  };
}

export default new CommandService();
