import { SplittedCommand } from '../interfaces/Package';
import HistoryCommands from '../models/HistoryCommands';
import HistoryCommandRepository from '../repositories/HistoryCommandRepository';
import SendCommandRepository from '../repositories/SendCommandRepository';

class CommandService {
  execute = async (
    command: SplittedCommand | Record<string, string>,
  ): Promise<HistoryCommands> => {
    const typedCommand = this.typingCommand(command);

    await SendCommandRepository.getRepository().removeSendCommand(
      typedCommand.deviceId,
      typedCommand.commandName,
    );

    return HistoryCommandRepository.getRepository().saveCommand(typedCommand);
  };

  typingCommand = (
    data: SplittedCommand | Record<string, string>,
  ): HistoryCommands => {
    const {
      deviceId,
      data: commandData,
      manufacturer,
      commandName,
      sentDate,
      requestDate,
    } = data;

    return {
      deviceId,
      data: commandData,
      manufacturer,
      commandName,
      sentDate: new Date(sentDate),
      requestDate: new Date(requestDate),
      confirmDate: new Date(),
    };
  };
}

export default new CommandService();
