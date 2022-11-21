import { shade, transparentize } from 'polished';
import styled, {
  css,
  DefaultTheme,
  FlattenInterpolation,
  ThemeProps,
} from 'styled-components';

import { Collapse } from '@chakra-ui/react';

export const ContainerCollapse = styled(Collapse)`
  border-bottom-width: thin;
`;

export const ContentCollapse = styled.div`
  height: 112px;
  max-height: 112px;
  display: flex;
  flex-direction: row;
  padding: 8px 0;
`;

export const ContentButtons = styled.div`
  width: 42px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin-left: 16px;
`;

type VariantButtonsType = (
  variant: 'commands' | 'reports',
) => FlattenInterpolation<ThemeProps<DefaultTheme>>;

const variantButtons: VariantButtonsType = (variant) => {
  const variants = {
    commands: css`
      background-color: ${({ theme }) => theme.colors.secundary};

      :hover {
        background-color: ${({ theme }) => shade(0.1, theme.colors.secundary)};
      }
    `,
    reports: css`
      background-color: ${({ theme }) => theme.colors.primary};

      :hover {
        background-color: ${({ theme }) => shade(0.1, theme.colors.primary)};
      }
    `,
  };

  return variants[variant];
};

type ButtonRedirectsProps = {
  variant: 'commands' | 'reports';
};

export const ButtonRedirects = styled.button<ButtonRedirectsProps>`
  width: 42px;
  height: 42px;

  display: flex;
  justify-content: center;
  align-items: center;

  border-radius: 50%;
  color: ${({ theme }) => theme.colors.white};

  box-shadow: 0px 7px 18px
    ${({ theme }) => transparentize(0.9, theme.colors.primary)};

  ${({ variant }) => variantButtons(variant)}
`;

export const ContentChart = styled.div`
  border-right-width: thin;
`;

export const WraperContent = styled.div`
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
  flex: 1;
`;

export const Row = styled.div`
  flex: 1;
  border-right-width: thin;
  padding: 0 40px;
`;

export const ContentRow = styled.div`
  border-bottom-width: thin;
  margin: 4px 0;

  > strong {
    margin-right: 5px;
  }
`;
