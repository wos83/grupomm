import React from 'react';
import { Shadow } from 'react-native-shadow-2';
import { useTheme } from 'styled-components';

import { BottomTabBarProps } from '@react-navigation/bottom-tabs';
import { TabActions } from '@react-navigation/native';

import {
  Container,
  CustomIcon,
  CustomIconContainer,
  Gradient,
  Icon,
  IconContainer,
  MenuButton,
  shadows,
  styles,
} from './styles';

const TabBar = (props: BottomTabBarProps): JSX.Element => {
  const theme = useTheme();

  const buttons = [
    { icon: 'home', color: theme.colors.white },
    { icon: 'map', color: theme.colors.white, isRoundered: true },
    { icon: 'chart-bar', color: theme.colors.white },
  ];

  const {
    state: { index, routes, key },
    navigation,
  } = props;

  const isRoundered = (idx: number): boolean => {
    return idx + 1 === (buttons.length + 1) / 2;
  };

  const isSelected = (idx: number): boolean => {
    return idx === index;
  };

  const onPress = (routeKey: string, routeName: string): void => {
    const event = navigation.emit({
      type: 'tabPress',
      target: routeKey,
      canPreventDefault: true,
    });

    if (!event.defaultPrevented) {
      navigation.dispatch({
        ...TabActions.jumpTo(routeName),
        target: key,
      });
    }
  };

  return (
    <Container>
      <Shadow {...shadows.content}>
        <Gradient>
          {routes.map((route, idx) => (
            <MenuButton key={route.key}>
              <IconContainer>
                <CustomIcon
                  isRoundered={isRoundered(idx)}
                  style={isRoundered(idx) && styles.rounderedButton}>
                  <CustomIconContainer
                    onPress={() => onPress(route.key, route.name)}
                    activeOpacity={0.5}>
                    <Icon
                      color={buttons[idx].color}
                      isSelected={isSelected(idx)}
                      name={buttons[idx].icon}
                    />
                  </CustomIconContainer>
                </CustomIcon>
              </IconContainer>
            </MenuButton>
          ))}
        </Gradient>
      </Shadow>
    </Container>
  );
};

export default TabBar;
