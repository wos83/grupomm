import { getRepository, Repository } from 'typeorm';

import { Package } from '../interfaces/Package';
import Packages from '../models/Packages';

class PackageRepository {
  private ormRepository: Repository<Packages>;

  public getRepository(): PackageRepository {
    this.ormRepository = getRepository(Packages);

    return this;
  }

  savePackage = ({ manufacturer, pack }: Package): void => {
    this.ormRepository.insert({ manufacturer, pack });
  };
}

export default new PackageRepository();
