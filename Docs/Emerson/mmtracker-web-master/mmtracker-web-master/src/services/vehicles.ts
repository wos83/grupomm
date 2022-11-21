import { AxiosResponse } from 'axios';

import { IDataPosition, IGridColumns } from '../interfaces/positions';
import Api from './api';

type IVehicleResponse = {
  data: Array<IDataPosition>;
  tableColumns: Array<IGridColumns>;
};

const VehicleService = {
  getVehiclePositions: (): Promise<AxiosResponse<Array<IVehicleResponse>>> =>
    Api.get('getVehiclePositions'),
};

export default VehicleService;
