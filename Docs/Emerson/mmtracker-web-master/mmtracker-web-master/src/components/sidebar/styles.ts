import { transparentize } from 'polished';
import styled, { css } from 'styled-components';

export const Container = styled.div`
  position: absolute;
  width: 88px;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  border-radius: 32px 0 0 32px;
  background: ${({ theme }) =>
    `radial-gradient(50% 50% at 50% 50%, ${theme.gradients.primary.start} 0%, ${theme.gradients.primary.end} 100%)`};

  @media (max-width: 480px) {
    width: 100%;
    height: 88px;

    border-radius: 0 0 32px 32px;

    flex-direction: row;
  }
`;

const getFlexAndAlignmentsCenter = (direction = 'column') => css`
  display: flex;
  flex-direction: ${direction};
  justify-content: center;
  align-items: center;
`;

const getSizeContentIcons = () => css`
  width: 50px;
  height: 50px;
`;

type SelectedPageProps = {
  position?: number;
};

export const SelectedPage = styled.div<SelectedPageProps>`
  position: absolute;
  z-index: 5;

  border-radius: 8px;
  box-shadow: inset 0px 4px 4px
    ${({ theme }) => transparentize(0.5, theme.colors.black)};
  background-color: ${({ theme }) => theme.colors.menuSelected};

  transition-duration: 500ms;

  ${getFlexAndAlignmentsCenter()}
  ${getSizeContentIcons()}

  @media (min-width: 481px) {
    top: ${({ position }) => `${position}px`};
  }

  @media (max-width: 480px) {
    left: ${({ position }) => `${position}px`};
  }
`;

export const ContentLogo = styled.div`
  ${getFlexAndAlignmentsCenter()}
  width: 50px;

  @media (min-width: 481px) {
    width: 100%;
    height: 13%;
  }
`;

export const ContentIcons = styled.div`
  ${getFlexAndAlignmentsCenter('row')}

  position: relative;

  @media (min-width: 481px) {
    ${getFlexAndAlignmentsCenter()}
  }
`;

export const ContentIcon = styled.div`
  ${getSizeContentIcons()}
  margin: 5px 0;
  z-index: 10;

  background-color: transparent;
  cursor: pointer;

  ${getFlexAndAlignmentsCenter('row')}

  @media (max-width: 480px) {
    margin: 0 5px;
  }
`;

export const ContentCogIcon = styled.div`
  ${getFlexAndAlignmentsCenter()}

  @media (min-width: 481px) {
    height: 13%;
  }
`;
