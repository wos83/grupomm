import 'dotenv/config';

import CreateOrGetConnection from './config/CreateOrGetConnection';
import PackageService from './services/PackageService';

CreateOrGetConnection();

const start = async () => {
  PackageService.execute();
};

setTimeout(() => start(), 1000);
