import { AxiosResponse } from 'axios';

import { IDataEvent } from '../interfaces/events';
import Api from './api';

type IEventResponse = {
  data: Array<IDataEvent>;
};

const EventsService = {
  getAllEvents: (): Promise<AxiosResponse<Array<IEventResponse>>> =>
    Api.get('getAllEvents'),
};

export default EventsService;
