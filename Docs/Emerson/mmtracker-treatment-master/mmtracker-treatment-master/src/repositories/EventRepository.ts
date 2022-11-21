import { getRepository, Repository } from 'typeorm';

import OpenEvent from '../models/OpenEvent';

class EventRepository {
  private ormRepository: Repository<OpenEvent>;

  public getRepository(): EventRepository {
    this.ormRepository = getRepository(OpenEvent);

    return this;
  }

  saveEvent = async (event: OpenEvent): Promise<OpenEvent> => {
    return this.ormRepository.save(event);
  };
}

export default new EventRepository();
