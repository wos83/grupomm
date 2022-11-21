import { LinearGradient } from 'expo-linear-gradient';
import { ShadowProps } from 'react-native-shadow-2';
import styled from 'styled-components/native';

export const shadows = {
  content: {
    containerViewStyle: {
      marginBottom: 24,
      background: '#ebedf4',
    },
    distance: 2,
    offset: [0, 2],
    radius: 28,
  } as ShadowProps,
};

export const Container = styled.View`
  width: 100%;
  justify-content: center;
  align-items: center;
`;

export const LogoContent = styled.View`
  width: 100%;
  height: 50%;

  z-index: 2;
  overflow: hidden;
  border-bottom-left-radius: 40px;
`;

export const Logo = styled(LinearGradient)`
  width: 100%;
  height: 100%;

  justify-content: center;
  align-items: center;
`;

export const FormContent = styled.SafeAreaView`
  width: 100%;
  height: 50%;
  background-color: ${({ theme }) => theme.colors.white};
  border-top-right-radius: 40px;
  z-index: 2;

  display: flex;
  justify-content: center;
  align-items: center;
`;

export const Divider = styled.SafeAreaView`
  width: 100%;
  height: 100px;
  position: absolute;
  background-color: ${({ theme }) => theme.colors.endGradientPrimary};
`;

export const HalfDivider = styled.SafeAreaView`
  width: 50%;
  height: 100%;
  background-color: ${({ theme }) => theme.colors.white};
`;

export const InputLogin = styled.TextInput`
  width: 100%;
  font-size: 16px;
  padding-left: 16px;
`;

export const InputContainer = styled.View`
  width: 300px;
  height: 56px;
  border-radius: 28px;
  flex-direction: row;
  align-items: center;
  padding-left: 16px;
`;

export const ButtonLogin = styled.TouchableOpacity`
  width: 300px;
  height: 56px;
  border-radius: 28px;
  font-size: 18px;
  background-color: ${({ theme }) => theme.colors.primary};

  justify-content: center;
`;

export const TextButtonLogin = styled.Text`
  color: ${({ theme }) => theme.colors.white};
  font-size: 14px;
  text-align: center;
`;
