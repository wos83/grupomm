import React from 'react';
import { ButtonProps, Text } from 'react-native';
import FontAwesome5 from 'react-native-vector-icons/FontAwesome5';
import { useTheme } from 'styled-components';

import { Container, shadowStyles } from './styles';

interface IButtonProps extends ButtonProps {
  color?: string;
  iconColor?: string;
  iconName?: string;
  iconSize?: number;
  label?: string;
  rotation?: boolean;
}

const Button = ({
  onPress,
  color,
  disabled,
  iconColor,
  iconName,
  iconSize,
  label,
  rotation = false,
  ...props
}: IButtonProps): JSX.Element => {
  const theme = useTheme();

  return (
    <Container
      onPress={onPress}
      activeOpacity={0.5}
      color={color || theme.colors.primary}
      disabled={disabled}
      style={shadowStyles.container}
      {...props}>
      {iconName && (
        <FontAwesome5
          name={iconName}
          color={iconColor}
          size={iconSize}
          style={{ transform: [{ rotateX: rotation ? '180deg' : '0deg' }] }}
        />
      )}
      {label && <Text>{label}</Text>}
    </Container>
  );
};
export default Button;
