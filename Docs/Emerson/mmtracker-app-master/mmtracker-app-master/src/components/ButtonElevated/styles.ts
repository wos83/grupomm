import { StyleSheet, Platform } from 'react-native';
import SimpleLineIcons from 'react-native-vector-icons/SimpleLineIcons';
import styled from 'styled-components/native';

type IButtonProps = {
  side: string;
};

export const ButtonContainer = styled.TouchableOpacity<IButtonProps>`
  width: 48px;
  height: 48px;
  position: absolute;
  top: ${Platform.OS === 'ios' ? 48 : 40}px;
  left: ${({ side }) => (side === 'left' ? '20px' : 'auto')};
  right: ${({ side }) => (side === 'right' ? '20px' : 'auto')};
  justify-content: center;
  align-items: center;

  background: ${({ theme }) => theme.colors.white};
  border-radius: 12px;
`;

export const Icon = styled(SimpleLineIcons)`
  font-size: 24px;
`;

export const shadowStyles = StyleSheet.create({
  container: {
    shadowColor: 'rgba(0,0,0, .4)',
    shadowOffset: { height: 1, width: 1 },
    shadowOpacity: 1,
    shadowRadius: 1,
    elevation: 2,
  },
});
