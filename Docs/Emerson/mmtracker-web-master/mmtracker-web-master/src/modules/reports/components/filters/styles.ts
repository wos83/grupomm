import { transparentize } from 'polished';
import styled from 'styled-components';

type ExpandProps = {
  expanded: boolean;
  heightScreen: number;
};

export const Expand = styled.div<ExpandProps>`
  height: 32px;
  left: ${({ expanded }) => (expanded ? 464 : 96)}px;
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  transition-duration: 500ms;
  width: 20px;
  z-index: 100;

  > button {
    @media (max-width: 480px) {
      transform: rotate(-90deg);
    }

    > svg {
      transform: ${({ expanded }) =>
        expanded ? 'rotate(-90deg)' : 'rotate(90deg)'} !important;
      transition-duration: 500ms;
    }
  }

  @media (max-width: 480px) {
    bottom: ${({ expanded, heightScreen }) =>
      expanded ? heightScreen - 48 : 96}px;
    left: 50%;
    top: auto;
    transform: translateX(-50%);
    transform: translateY(0);
  }
`;

type ContainerProps = {
  expanded: boolean;
  heightScreen: number;
};

export const Container = styled.div<ContainerProps>`
  background-color: ${({ theme }) =>
    transparentize(0.1, theme.colors.background)};
  display: flex;
  height: 100%;
  max-width: ${({ expanded }) => (expanded ? 368 : 0)}px;
  opacity: ${({ expanded }) => (expanded ? 1 : 0.5)};
  overflow: hidden;
  position: absolute;
  top: 0;
  transition-duration: 500ms;
  z-index: 100;

  @media (max-width: 480px) {
    bottom: 88px;
    max-height: ${({ expanded, heightScreen }) =>
      expanded ? heightScreen - 140 : 0}px;
    max-width: none;
    overflow: auto;
    top: auto;
    width: 100%;
  }
`;

export const Content = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  min-width: 364px;
  padding: 0 16px;

  @media (max-width: 480px) {
    min-width: 304px;
  }
`;

export const ContentTitle = styled.div`
  align-items: center;
  display: flex;
  height: 136px;
  justify-content: center;
  width: 100%;

  > b {
    font-size: 32px;
    font-weight: 500;
  }
`;

export const ContentDateFilter = styled.div`
  display: flex;
  justify-content: space-between;

  > div {
    width: 48%;
  }
`;

export const ContentReportsType = styled.div`
  margin: 32px 0;
`;

export const ContentFilterButton = styled.div`
  align-items: center;
  display: flex;
  justify-content: center;
  padding: 16px;
`;
