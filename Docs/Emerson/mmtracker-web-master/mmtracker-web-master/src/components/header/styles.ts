import styled, {
  css,
  DefaultTheme,
  FlattenInterpolation,
  ThemeProps,
} from 'styled-components';

import { Box, Grid } from '@chakra-ui/react';

import { Types } from './interfaces/header';

export const Container = styled.div`
  height: 64px;
  display: flex;

  border-radius: 0 32px 0 0;

  background-color: transparent;
`;

export const ContentSearch = styled(Grid)`
  width: 25%;
  display: flex;
  align-items: center;

  margin-left: 48px;

  font-size: 14px;

  @media (max-width: 479px) {
    width: 70%;
    margin-left: 16px;
  }

  @media (max-width: 480px) and (max-width: 767px) {
    width: 55%;
  }

  @media (min-width: 768px) and (max-width: 979px) {
    width: 40%;
  }
`;

export const ContentNotifications = styled(Box)`
  display: flex;
  justify-content: flex-end;
  align-items: center;
  flex: 1;

  margin-right: 32px;

  @media (max-width: 480px) {
    margin-right: 0;
  }
`;

export const ContentIcon = styled.div`
  position: relative;
  margin: 0 16px;
  cursor: pointer;

  @media (max-width: 480px) {
    margin: 0 8px;
  }
`;

type NotificationType = (
  currentTypes: Types,
) => FlattenInterpolation<ThemeProps<DefaultTheme>>;

const notificationTypes: NotificationType = (currentTypes) => {
  const types = {
    alarm: css`
      background-color: ${({ theme }) => theme.colors.alarm};
    `,
    notification: css`
      background-color: ${({ theme }) => theme.colors.notification};
    `,
  };

  return types[currentTypes];
};

type CounterProps = {
  type: Types;
};

export const Counter = styled.div<CounterProps>`
  width: 32px;
  height: 16px;
  text-align: center;
  line-height: 16px;

  position: absolute;
  top: 24px;
  margin-left: 16px;

  border-radius: 4px;
  color: ${({ theme }) => theme.colors.white};
  font-weight: bold;

  ${({ type }) => notificationTypes(type)}

  @media (max-width: 480px) {
    width: 24px;
    height: 16px;

    font-size: 10px;
  }
`;
