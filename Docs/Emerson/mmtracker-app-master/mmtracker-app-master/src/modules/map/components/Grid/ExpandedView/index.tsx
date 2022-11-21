import { transparentize } from 'polished';
import React, { useState } from 'react';
import Animated, { EasingNode } from 'react-native-reanimated';
import { Shadow } from 'react-native-shadow-2';
import GestureRecognizer from 'react-native-swipe-gestures';
import { useTheme } from 'styled-components';

import { CommonActions, useNavigation } from '@react-navigation/native';

import Button from '../../../../../components/Button';
import {
  AnimationExpandedView,
  ButtonWrapper,
  Container,
  ContentButton,
  Icon,
  shadows,
} from './styles';

const ExpandedView = (): JSX.Element => {
  const navigation = useNavigation();
  const theme = useTheme();

  const [sizeViewExpand, setSizeViewExpand] = useState<number>(0);

  const widthAnim = new Animated.Value(0);
  const widthExpandedView = widthAnim.interpolate({
    inputRange: [0, 1],
    outputRange: [32, sizeViewExpand],
  });

  const maxWidthAnimate = () => {
    Animated.timing(widthAnim, {
      easing: EasingNode.linear,
      toValue: 1,
      duration: 250,
    }).start();
  };

  const minWidthAnimate = () => {
    Animated.timing(widthAnim, {
      easing: EasingNode.linear,
      toValue: 0,
      duration: 250,
    }).start();
  };

  const handlePressShortcutButtons = (routeName: string) => {
    console.log(routeName);

    navigation.dispatch(
      CommonActions.reset({
        index: 0,
        routes: [{ name: routeName }],
      }),
    );
  };

  return (
    <Container onLayout={(e) => setSizeViewExpand(e.nativeEvent.layout.width)}>
      <Shadow {...shadows.animatedView}>
        <GestureRecognizer
          onSwipeLeft={maxWidthAnimate}
          onSwipeRight={minWidthAnimate}>
          <AnimationExpandedView
            style={{
              width: widthExpandedView,
            }}>
            <Icon
              color={transparentize(0.6, theme.colors.primary)}
              name="grip-lines-vertical"
              size={14}
            />
            <ButtonWrapper>
              <ContentButton>
                <Button
                  onPress={() => handlePressShortcutButtons('Commands')}
                  title="commands"
                  color={theme.colors.secundary}
                  iconName="lock"
                  iconSize={24}
                  iconColor={theme.colors.white}
                />
              </ContentButton>
              <ContentButton>
                <Button
                  onPress={() => handlePressShortcutButtons('Reports')}
                  title="reports"
                  iconName="chart-bar"
                  iconSize={24}
                  iconColor={theme.colors.white}
                />
              </ContentButton>
            </ButtonWrapper>
          </AnimationExpandedView>
        </GestureRecognizer>
      </Shadow>
    </Container>
  );
};

export default ExpandedView;
