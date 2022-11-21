import { transparentize } from 'polished';
import { Platform } from 'react-native';
import { RFPercentage } from 'react-native-responsive-fontsize';
import { ShadowProps } from 'react-native-shadow-2';
import { FlattenInterpolation } from 'styled-components';
import styled, {
  css,
  DefaultTheme,
  ThemeProps,
} from 'styled-components/native';

export const shadows = {
  card: {
    containerViewStyle: { marginBottom: 8 },
    corners: ['bottomLeft', 'bottomRight'],
    distance: 6,
    radius: 16,
    sides: ['bottom'],
  } as ShadowProps,
  headerList: {
    containerViewStyle: { marginBottom: 8 },
    distance: 5,
    radius: 8,
    startColor: '#0001',
    viewStyle: { width: '100%' },
  } as ShadowProps,
};

type GridSizeType = (
  gridExpanded: boolean,
  gridMinimized: boolean,
  heightDevice: number,
) => FlattenInterpolation<ThemeProps<DefaultTheme>>;

const gridSize: GridSizeType = (gridExpanded, gridMinimized, heightDevice) => {
  let state: 'default' | 'expanded' | 'minimized' = 'default';

  if (gridExpanded && !gridMinimized) {
    state = 'expanded';
  } else if (gridMinimized && !gridExpanded) {
    state = 'minimized';
  }

  const types = {
    expanded: css`
      max-height: ${heightDevice - 200}px;
    `,
    minimized: css`
      max-height: ${Platform.OS === 'ios' ? '152px' : '144px'};
    `,
    default: css`
      max-height: ${Platform.OS === 'ios' ? '336px' : '328px'}; ;
    `,
  };

  return types[state];
};

type ContainerProps = {
  gridExpanded: boolean;
  gridMinimized: boolean;
  heightDevice: number;
};

export const Container = styled.View<ContainerProps>`
  position: absolute;
  max-height: 240px;
  width: 96%;
  bottom: 88px;

  background-color: transparent;
  z-index: 100;

  ${({ gridExpanded, gridMinimized, heightDevice }) =>
    gridSize(gridExpanded, gridMinimized, heightDevice)};
`;

export const HeaderList = styled.View`
  height: 40px;
  flex-direction: row;
  justify-content: space-between;
  border-radius: 8px;
  padding: 6px 8px;
  background-color: ${({ theme }) => theme.colors.lightestGray};
`;

export const ContentSearch = styled.View`
  width: 60%;
`;

export const ButtonWrapper = styled.View`
  flex: 1;
  justify-content: space-between;
  align-items: center;
  flex-direction: row;
  padding-left: 8px;
`;

export const ContentButton = styled.View`
  width: 47%;
  height: 100%;
`;

export const List = styled.ScrollView`
  width: 100%;
  height: 100%;
`;

export const Content = styled.View`
  height: 88px;
  width: 100%;
  flex-direction: row;

  border-radius: 10px;
  background-color: ${({ theme }) => theme.colors.white};
`;

export const ContentImage = styled.View`
  height: 100%;
  width: 64px;
  padding: 4px;
  justify-content: center;
`;

export const Image = styled.Image`
  height: 56px;
  width: 56px;
`;

export const ContentIdentifier = styled.View`
  flex: 1;
  justify-content: center;
  align-items: center;
  padding-right: 16px;
`;

export const Plate = styled.Text`
  color: ${({ theme }) => theme.colors.darkText};
  font-size: ${RFPercentage(2.4)}px;
  font-weight: 700;
`;

export const Surname = styled.Text`
  color: ${({ theme }) => theme.colors.darkText};
  font-size: ${RFPercentage(1.3)}px;
  text-align: center;
`;

export const ContentData = styled.View`
  width: 56%;
  max-height: 88px;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
`;

type DataRowProps = {
  minWidth?: number;
};

export const DataRow = styled.View<DataRowProps>`
  min-height: 25px;
  min-width: ${({ minWidth }) => minWidth}px;
  padding: 4px 8px;
  flex-direction: row;
  align-items: center;

  border-color: ${({ theme }) => transparentize(0.85, theme.colors.primary)};
  border-left-width: 1px;
`;

export const Icon = styled.View`
  width: 24px;
`;

export const Text = styled.Text`
  color: ${({ theme }) => theme.colors.darkText};
`;
