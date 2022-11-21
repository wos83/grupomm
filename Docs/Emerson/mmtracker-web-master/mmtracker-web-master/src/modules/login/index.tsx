import { useState } from 'react';
import { useNavigate } from 'react-router';

import infoLine from '@iconify/icons-clarity/info-line';
import lockLine from '@iconify/icons-clarity/lock-line';
import userLine from '@iconify/icons-clarity/user-line';

import logo from '../../assets/img/logo.png';
import paper from '../../assets/img/paper.png';
import AuthService from '../../services/auth';
import {
  Container,
  ImageContent,
  FormContent,
  Input,
  ImageLogo,
  ImagePaper,
  ButtonLogin,
} from './styles';

function Login(): JSX.Element {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  const handlerLogin = async () => {
    const { data } = await AuthService.login({
      username,
      password,
    });

    console.log({ daa: data.status });

    if (data.status === 'success')
      navigate('/mmtracker/map', { replace: true });
  };

  return (
    <Container>
      <ImageContent flex="1">
        <ImagePaper src={paper} alt="Paper" />
      </ImageContent>
      <FormContent>
        <ImageLogo src={logo} alt="Logo" />
        <Input
          placeholder="Usuário"
          icon={userLine}
          value={username}
          onChange={(event) => setUsername(event.target.value)}
        />
        <Input
          placeholder="Senha"
          icon={lockLine}
          value={password}
          onChange={(event) => setPassword(event.target.value)}
          rightIcon={infoLine}
        />
        <ButtonLogin onClick={handlerLogin}>ENTRAR</ButtonLogin>
      </FormContent>
    </Container>
  );
}

export default Login;
