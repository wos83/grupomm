import styled, {
  css,
  DefaultTheme,
  FlattenInterpolation,
  ThemeProps,
} from 'styled-components';

type TextColorType = (
  percentBattery: number,
) => FlattenInterpolation<ThemeProps<DefaultTheme>>;

const textColor: TextColorType = (percentBattery) => {
  let style;

  const types = {
    0: css`
      color: ${({ theme }) => theme.colors.alarm};
    `,
    '1-20': css`
      color: ${({ theme }) => theme.colors.notification};
    `,
    100: css`
      color: ${({ theme }) => theme.colors.success};
    `,
  };

  Object.keys(types).some((k) => {
    const part = k.split('-');
    if (
      percentBattery >= +part[0] &&
      percentBattery <= (+part[1] || +part[0])
    ) {
      style = types[k as keyof typeof types];
      return true;
    }
    return false;
  });

  return (
    style ||
    css`
      color: ${({ theme }) => theme.colors.darkText};
    `
  );
};

type ContentProps = {
  percentBattery: number;
};

export const Content = styled.div<ContentProps>`
  align-items: center;
  display: flex;
  justify-content: center;
  width: 100%;

  > div {
    align-items: center;
    display: flex;
    justify-content: space-between;
    width: 90%;

    ${({ percentBattery }) => textColor(percentBattery)}

    @media (max-width: 1526px) {
      width: 100%;
    }

    > img {
      margin-right: 10%;
    }
  }
`;
