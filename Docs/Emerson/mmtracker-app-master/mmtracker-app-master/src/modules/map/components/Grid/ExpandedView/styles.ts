import Animated from 'react-native-reanimated';
import { ShadowProps } from 'react-native-shadow-2';
import FontAwesome5 from 'react-native-vector-icons/FontAwesome5';
import styled from 'styled-components/native';

export const shadows = {
  animatedView: {
    corners: ['bottomLeft', 'topLeft'],
    distance: 4,
    radius: 10,
  } as ShadowProps,
};

export const Container = styled.View`
  position: absolute;
  width: 56%;
  height: 100%;
  align-items: flex-end;
  right: 0;

  overflow: hidden;
`;

export const AnimationExpandedView = styled(Animated.View)`
  height: 100%;
  flex-direction: row;
  align-items: center;
  justify-content: flex-start;

  border-radius: 10px;
  background-color: ${({ theme }) => theme.colors.lightestGray};
`;

export const Icon = styled(FontAwesome5)`
  padding: 0 8px;
`;

export const ButtonWrapper = styled.View`
  width: 94%;
  height: 100%;
  padding-left: 32px;
  position: absolute;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
`;

export const ContentButton = styled.View`
  width: 45%;
  height: 80%;
`;
