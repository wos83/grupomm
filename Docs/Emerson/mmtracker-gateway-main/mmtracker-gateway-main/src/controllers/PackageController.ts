import { Device } from '../interfaces/Device';
import PackageRepository from '../repositories/PackageRepository';

const packageHandling = (currentDevice: Device, data: Buffer): void => {
  PackageRepository.getRepository().savePackage({
    manufacturer: currentDevice.manufacturer || '',
    pack: data.toString(),
  });
};

export default packageHandling;
