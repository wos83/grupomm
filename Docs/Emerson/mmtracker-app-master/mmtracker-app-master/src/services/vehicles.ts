import { AxiosResponse } from 'axios';

import { IDataPosition } from '../interfaces/positions';
import Api from './api';

type IVehicleResponse = {
  data: Array<IDataPosition>;
};

const VehicleService = {
  getVehiclePositions: (): Promise<AxiosResponse<Array<IVehicleResponse>>> =>
    Api.get('getVehiclePositions'),
};

export default VehicleService;
