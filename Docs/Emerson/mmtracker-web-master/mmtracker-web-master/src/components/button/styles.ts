import { shade, transparentize } from 'polished';
import styled, {
  css,
  DefaultTheme,
  FlattenInterpolation,
  ThemeProps,
} from 'styled-components';

type GetVariantColorsType = (
  variant: 'primary' | 'secundary' | 'green',
) => FlattenInterpolation<ThemeProps<DefaultTheme>>;

const getVariantColors: GetVariantColorsType = (variant) => {
  const variants = {
    primary: css`
      background-color: ${({ theme }) => theme.colors.primary};

      :hover:enabled {
        background-color: ${({ theme }) => shade(0.1, theme.colors.primary)};
      }
    `,
    secundary: css`
      background-color: ${({ theme }) => theme.colors.secundary};

      :hover:enabled {
        background-color: ${({ theme }) => shade(0.1, theme.colors.secundary)};
      }
    `,

    green: css`
      background-color: ${({ theme }) => theme.colors.success};

      :hover:enabled {
        background-color: ${({ theme }) => shade(0.1, theme.colors.success)};
      }
    `,
  };

  const style = variants[variant];

  if (style) return style;

  return css`
    background-color: ${variant};

    :hover:enabled {
      background-color: ${shade(0.1, variant)};
    }
  `;
};

type ButtonContainerProps = {
  color: 'primary' | 'secundary' | 'green';
  padding?: number;
};

export const ButtonContainer = styled.button<ButtonContainerProps>`
  width: 100%;
  height: 42px;
  padding: ${({ padding }) => (padding ? `${padding}px` : '10px 14px')};

  display: flex;
  align-items: center;
  justify-content: space-between;

  border-radius: 12px;

  ${({ color }) => getVariantColors(color)};
  color: ${({ theme }) => theme.colors.white};
  box-shadow: 0px 7px 18px
    ${({ theme }) => transparentize(0.9, theme.colors.primary)};

  :disabled {
    background-color: ${({ theme }) => theme.colors.disabled};
    color: ${({ theme }) => transparentize(0.8, theme.colors.black)};
    cursor: default;
  }
`;

export const Text = styled.strong`
  font-size: 14px;
  text-transform: uppercase;
`;
