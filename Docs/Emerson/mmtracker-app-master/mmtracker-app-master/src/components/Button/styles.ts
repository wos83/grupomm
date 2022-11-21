import { transparentize } from 'polished';
import { StyleSheet } from 'react-native';
import styled from 'styled-components/native';

type ContainerProps = {
  color: string;
};

export const Container = styled.TouchableOpacity<ContainerProps>`
  width: 100%;
  height: 100%;

  justify-content: center;
  align-items: center;

  border-radius: 8px;
  background-color: ${({ color, disabled }) =>
    !disabled ? color : transparentize(0.5, color)};
`;

export const shadowStyles = StyleSheet.create({
  container: {
    shadowColor: 'rgba(0,0,0, .4)',
    shadowOffset: { height: 1, width: 0 },
    shadowOpacity: 1,
    shadowRadius: 1,
    elevation: 1,
  },
});
