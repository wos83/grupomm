import { getRepository, Repository } from 'typeorm';

import SendCommands from '../models/SendCommands';

class SendCommandRepository {
  private ormRepository: Repository<SendCommands>;

  public getRepository(): SendCommandRepository {
    this.ormRepository = getRepository(SendCommands);

    return this;
  }

  removeSendCommand = async (
    deviceId: string,
    commandName: string,
  ): Promise<void> => {
    await this.ormRepository.delete({ deviceId, commandName });
  };
}

export default new SendCommandRepository();
