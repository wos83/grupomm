import { transparentize } from 'polished';
import styled, { css, DefaultTheme } from 'styled-components';

import { Types } from '../interfaces/header';

type OverlayProps = {
  isVisible: boolean;
};

export const Overlay = styled.div<OverlayProps>`
  position: fixed;
  display: ${({ isVisible }) => (isVisible ? 'block' : 'none')};
  width: 100vw;
  height: 100vh;
  top: 0;
  left: 0;
  z-index: 100;
`;

type ContentModalProps = {
  isVisible: boolean;
};

export const ContentModal = styled.div<ContentModalProps>`
  background-color: ${({ theme }) => theme.colors.white};
  border-radius: 16px;
  box-shadow: 0px 7px 18px
    ${({ theme }) => transparentize(0.8, theme.colors.primary)};
  display: flex;
  flex-direction: column;
  height: 40%;
  position: fixed;
  right: 16px;
  top: ${({ isVisible }) => (isVisible ? '80px' : '150%')};
  transition: all 0.2s ease-out;
  width: 24%;
  z-index: 100;

  @media (max-width: 479px) {
    height: 64%;
    left: 50%;
    top: ${({ isVisible }) => (isVisible ? '80px' : '150%')};
    transform: translateX(-50%);
    width: 88%;
  }

  @media (min-width: 480px) and (max-width: 767px) {
    width: 56%;
  }

  @media (min-width: 768px) and (max-width: 979px) {
    width: 48%;
  }

  @media (min-width: 980px) and (max-width: 1199px) {
    width: 40%;
  }

  @media (min-width: 1200px) and (max-width: 1600px) {
    width: 32%;
  }
`;

export const Body = styled.div`
  flex: 1;
  overflow: scroll;

  ::-webkit-scrollbar-corner {
    background-color: transparent;
  }

  ::-webkit-scrollbar-track {
    margin: 12px 0 8px 0;
  }
`;

const getColorViolation = (type: Types, theme: DefaultTheme) => {
  const colors = {
    alarm: css`
      color: ${theme.colors.alarm};
    `,
    notification: css`
      color: ${theme.colors.notification};
    `,
  };

  return colors[type];
};

export const Row = styled.div`
  border-bottom-width: 1px;
  display: flex;
  flex-direction: row;
  padding: 8px;
  width: 100%;
`;

const getBackgroundColorImage = (type: Types, theme: DefaultTheme) => {
  const colors = {
    alarm: css`
      background-color: ${transparentize(0.5, theme.colors.alarm)};
    `,
    notification: css`
      background-color: ${transparentize(0.5, theme.colors.notification)};
    `,
  };

  return colors[type];
};

type ContentImagesProps = {
  warningType: Types;
};

export const ContentImages = styled.div<ContentImagesProps>`
  align-items: center;
  display: flex;
  justify-content: center;
  min-height: 100%;
  min-width: 88px;

  > div {
    align-items: center;
    display: flex;
    height: 72px;
    justify-content: center;
    width: 72px;

    border-bottom-right-radius: 32px;
    border-top-left-radius: 32px;

    ${({ theme, warningType }) => getBackgroundColorImage(warningType, theme)};
  }
`;

type ContentNotificationsProps = {
  warningType: Types;
};

export const ContentNotifications = styled.div<ContentNotificationsProps>`
  > div {
    margin-bottom: 8px;

    > strong {
      color: ${({ theme }) => theme.colors.darkText};
      font-size: 18px;
    }
  }

  > strong {
    font-size: 16px;
    ${({ theme, warningType }) => getColorViolation(warningType, theme)};
  }

  > h6 {
    color: ${({ theme }) => theme.colors.darkText};
    margin-top: 8px;
  }
`;
