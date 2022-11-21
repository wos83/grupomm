import { Platform, StyleSheet, TouchableOpacity } from 'react-native';
import { ShadowProps } from 'react-native-shadow-2';
import SimpleLineIcons from 'react-native-vector-icons/FontAwesome5';
import { FlattenInterpolation } from 'styled-components';
import styled, {
  css,
  DefaultTheme,
  ThemeProps,
} from 'styled-components/native';

export const shadows = {
  content: {
    containerViewStyle: {
      marginBottom: Platform.OS === 'ios' ? 24 : 16,
    },
    radius: { bottomLeft: 32, bottomRight: 32, topLeft: 4, topRight: 4 },
    viewStyle: {
      borderBottomLeftRadius: 32,
      borderBottomRightRadius: 32,
      borderTopLeftRadius: 4,
      borderTopRightRadius: 4,
    },
  } as ShadowProps,
};

export const styles = StyleSheet.create({
  rounderedButton: {
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.15,
    shadowRadius: 4,
    elevation: 4,
  },
});

export const Container = styled.View`
  width: 100%;
  justify-content: center;
  align-items: center;
  position: absolute;
  bottom: 0;
`;

export const Gradient = styled.View`
  width: 96%;
  height: 72px;
  flex-direction: row;

  border-bottom-left-radius: 32px;
  border-bottom-right-radius: 32px;
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;

  background-color: ${({ theme }) => theme.colors.primary};
`;

export const MenuButton = styled.SafeAreaView`
  flex: 1;
  align-items: center;
  justify-content: center;
`;

export const IconContainer = styled.View`
  align-items: center;
  justify-content: center;
`;

type CustomIconProps = {
  isRoundered: boolean;
};

const getStyleRoundered = (): FlattenInterpolation<
  ThemeProps<DefaultTheme>
> => css`
  border-radius: 50px;
  width: 80px;
  height: 80px;
  margin-bottom: 40px;

  background-color: ${({ theme }) => theme.colors.endGradientPrimary};
`;

export const CustomIcon = styled.View<CustomIconProps>`
  width: 72px;
  height: 72px;

  ${({ isRoundered }) => isRoundered && getStyleRoundered()};
`;

export const CustomIconContainer = styled(TouchableOpacity)`
  width: 100%;
  height: 100%;
  justify-content: center;
  align-items: center;
`;

type IconProps = {
  color: string;
  isSelected: boolean;
};

export const Icon = styled(SimpleLineIcons)<IconProps>`
  color: ${({ color, isSelected, theme }) =>
    isSelected ? theme.colors.secundary : color};

  font-size: 32px;
`;
