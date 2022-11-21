import { transparentize } from 'polished';
import styled from 'styled-components/native';

type ContainerProps = {
  border?: boolean;
};

export const Container = styled.View<ContainerProps>`
  height: 100%;
  width: 100%;
  flex-direction: row;
  border-radius: 5px;

  border-width: ${({ border }) => border && 1}px;

  border-color: ${({ theme }) => transparentize(0.7, theme.colors.primary)};
  background-color: ${({ theme }) => theme.colors.white};
`;

export const ContentIcon = styled.View`
  height: 100%;
  width: 30px;
  align-items: center;
  justify-content: center;
`;

export const TextInput = styled.TextInput`
  margin-left: 8px;
`;
