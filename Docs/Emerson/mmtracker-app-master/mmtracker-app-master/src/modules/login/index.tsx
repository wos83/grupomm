import React, { useState } from 'react';
import { Image } from 'react-native';
import { Shadow } from 'react-native-shadow-2';
import FontAwesome5Icon from 'react-native-vector-icons/FontAwesome5';

import { useNavigation, CommonActions } from '@react-navigation/native';

import logo from '../../assets/images/logo.png';
import theme from '../../themes/light';
import {
  Container,
  FormContent,
  Divider,
  HalfDivider,
  InputLogin,
  ButtonLogin,
  TextButtonLogin,
  LogoContent,
  Logo,
  shadows,
  InputContainer,
} from './styles';

const Login = (): JSX.Element => {
  const [userName, setUserName] = useState('');
  const [password, setPassword] = useState('');

  const navigation = useNavigation();

  const handleLogin = (): void => {
    navigation.dispatch(
      CommonActions.reset({
        index: 0,
        routes: [{ name: 'TabNavigation' }],
      }),
    );
  };

  return (
    <Container>
      <LogoContent>
        <Logo colors={theme.gradients.primary}>
          <Image source={logo} />
        </Logo>
      </LogoContent>
      <Divider>
        <HalfDivider />
      </Divider>
      <FormContent>
        <Shadow {...shadows.content}>
          <InputContainer>
            <FontAwesome5Icon name="user" size={20} color="#748AA1" />
            <InputLogin
              onChangeText={setUserName}
              value={userName}
              placeholder="Usuário"
              placeholderTextColor="#748AA1"
            />
          </InputContainer>
        </Shadow>
        <Shadow {...shadows.content}>
          <InputContainer>
            <FontAwesome5Icon name="lock" size={20} color="#748AA1" />
            <InputLogin
              onChangeText={setPassword}
              value={password}
              placeholder="Senha"
              placeholderTextColor="#748AA1"
            />
          </InputContainer>
        </Shadow>
        <Shadow {...shadows.content}>
          <ButtonLogin onPress={handleLogin}>
            <TextButtonLogin>ENTRAR</TextButtonLogin>
          </ButtonLogin>
        </Shadow>
      </FormContent>
    </Container>
  );
};

export default Login;
