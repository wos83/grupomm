import { getRepository, Repository } from 'typeorm';

import HistoryCommands from '../models/HistoryCommands';

class HistoryCommandRepository {
  private ormRepository: Repository<HistoryCommands>;

  public getRepository(): HistoryCommandRepository {
    this.ormRepository = getRepository(HistoryCommands);

    return this;
  }

  saveCommand = async (command: HistoryCommands): Promise<HistoryCommands> => {
    return this.ormRepository.save(command);
  };
}

export default new HistoryCommandRepository();
