import React from 'react';
import { GestureResponderEvent } from 'react-native';

import { ButtonContainer, Icon, shadowStyles } from './styles';

type IButtonProps = {
  onPress: (event: GestureResponderEvent) => void;
  iconName: string;
  side: string;
};

const ButtonElevated = ({
  onPress,
  iconName,
  side = 'left',
}: IButtonProps): JSX.Element => (
  <ButtonContainer
    onPress={onPress}
    activeOpacity={0.7}
    side={side}
    style={shadowStyles.container}>
    <Icon name={iconName} color="#1071E0" />
  </ButtonContainer>
);
export default ButtonElevated;
