import { getRepository, IsNull, LessThan, Repository } from 'typeorm';

import SendCommands from '../models/SendCommands';

class SendCommandsRepository {
  private ormRepository: Repository<SendCommands>;

  public getRepository(): SendCommandsRepository {
    this.ormRepository = getRepository(SendCommands);

    return this;
  }

  getCommands = async (): Promise<Array<SendCommands>> => {
    const commandIntervalDate = new Date();
    commandIntervalDate.setTime(new Date().getTime() - 15 * 60 * 1000);
    return this.ormRepository.find({
      where: [
        { sentDate: IsNull() },
        {
          sentDate: LessThan(commandIntervalDate),
        },
      ],
    });
  };

  updateSentCommand = async (id: number): Promise<void> => {
    this.ormRepository.update({ id }, { sentDate: new Date() });
  };
}

export default new SendCommandsRepository();
