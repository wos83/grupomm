import { getRepository, Repository } from 'typeorm';

import Position from '../models/Position';

class PositionRepository {
  private ormRepository: Repository<Position>;

  public getRepository(): PositionRepository {
    this.ormRepository = getRepository(Position);

    return this;
  }

  savePosition = async (position: Position): Promise<Position> => {
    return this.ormRepository.save(position);
  };
}

export default new PositionRepository();
