import PackageRepository from '../repositories/PackageRepository';
import { treatPack } from '../utils/treatPack';

class PackageService {
  execute = async () => {
    const packages = await PackageRepository.getRepository().getPackages();

    packages.forEach((item) => {
      treatPack(item)
        .then(() => {
          // PackageRepository.removePackage(item.id);
        })
        .catch((err) => {
          console.warn(err);
        });
    });
  };
}

export default new PackageService();
