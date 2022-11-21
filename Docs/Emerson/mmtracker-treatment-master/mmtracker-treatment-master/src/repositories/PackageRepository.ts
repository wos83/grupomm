import { getRepository, Repository } from 'typeorm';

import Package from '../models/Package';

class PackageRepository {
  private ormRepository: Repository<Package>;

  public getRepository(): PackageRepository {
    this.ormRepository = getRepository(Package);

    return this;
  }

  getPackages = async () => {
    return this.ormRepository.find();
  };

  removePackage = async (packId: number): Promise<void> => {
    await this.ormRepository.delete(packId);
  };
}

export default new PackageRepository();
