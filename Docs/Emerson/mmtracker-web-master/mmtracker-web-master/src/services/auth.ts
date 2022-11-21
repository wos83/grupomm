import { AxiosResponse } from 'axios';

import Api from './api';

interface ILoginData {
  username: string;
  password: string;
}

interface ILoginResponse {
  status: string;
}

const AuthService = {
  login: (data: ILoginData): Promise<AxiosResponse<ILoginResponse>> =>
    Api.post('login', data),
};

export default AuthService;
