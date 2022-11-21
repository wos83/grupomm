import { transparentize } from 'polished';
import styled, {
  css,
  DefaultTheme,
  FlattenInterpolation,
  ThemeProps,
} from 'styled-components';

import { Table as TableChakra, Tr as TrChakra } from '@chakra-ui/react';

export const ContentButtons = styled.div`
  display: flex;
  z-index: 10;
  margin: 0 16px 8px 0;

  @media (max-width: 480px) {
    margin-right: 2px;
  }
`;

type ExpandButtonProps = {
  gridExpanded: boolean;
};

export const ExpandButton = styled.div<ExpandButtonProps>`
  width: 42px;
  margin: 0 8px;

  > button > svg {
    transform: ${({ gridExpanded }) =>
      gridExpanded ? 'rotate(-180deg)' : 'rotate(0deg)'} !important;
    transition-duration: 500ms;
  }
`;

export const MinimizedButton = styled.div`
  width: 42;
`;

export const Container = styled.div`
  width: calc(100vw - 120px);
  display: flex;
  justify-content: center;
  z-index: 10;

  padding: 0 16px 16px 16px;

  @media (max-width: 480px) {
    width: 100%;

    padding: 0 2px 2px 2px;
  }
`;

type GridSizeType = (
  isMobile: boolean | undefined,
  gridExpanded: boolean,
  gridMinimized: boolean,
) => FlattenInterpolation<ThemeProps<DefaultTheme>>;

const gridSize: GridSizeType = (isMobile, gridExpanded, gridMinimized) => {
  let state: 'default' | 'expanded' | 'minimized' = 'default';

  if (gridExpanded && !gridMinimized) {
    state = 'expanded';
  } else if (gridMinimized && !gridExpanded) {
    state = 'minimized';
  }

  const types = {
    expanded: css`
      max-height: ${!isMobile ? 'calc(100vh -  264px)' : 'calc(100vh - 312px)'};
    `,
    minimized: css`
      max-height: 0px;
    `,
    default: css`
      max-height: ${!isMobile ? '320px' : '200px'}; ;
    `,
  };

  return types[state];
};

type ContentGridProps = {
  gridExpanded: boolean;
  gridMinimized: boolean;
};

export const ContentGrid = styled.div<ContentGridProps>`
  width: 100%;

  overflow: scroll;
  z-index: 10;

  border-radius: 16px;
  background-color: ${({ theme }) => theme.colors.white};
  transition-duration: 500ms;

  box-shadow: 0px 7px 18px
    ${({ theme }) => transparentize(0.9, theme.colors.primary)};

  ${({ gridExpanded, gridMinimized }) =>
    gridSize(false, gridExpanded, gridMinimized)};

  ::-webkit-scrollbar-track {
    margin: 40.5px 10px 8px 10px;
  }

  ::-webkit-scrollbar-corner {
    background-color: transparent;
  }

  @media (max-width: 480px) {
    ${({ gridExpanded, gridMinimized }) =>
      gridSize(true, gridExpanded, gridMinimized)};
  }
`;

export const Table = styled(TableChakra)`
  background-color: ${({ theme }) => theme.colors.white};
`;

export const Th = styled.th`
  position: sticky;
  top: 0px;
  padding: 12px 20px;
  z-index: 10;
  white-space: nowrap;
  text-align: center;

  background-color: ${({ theme }) => theme.colors.white};
  color: ${({ theme }) => theme.colors.primary};
`;

type TrProps = {
  striped?: number;
};

export const Tr = styled(TrChakra)<TrProps>`
  background-color: ${({ theme, striped }) =>
    striped ? 'transparent' : transparentize(0.7, theme.colors.background)};
`;

type TdProps = {
  collapseComponent?: boolean;
  firstElement?: boolean;
  isBackupBatteryColumn?: boolean;
  isCollapse?: boolean;
  padding?: number;
};

export const Td = styled.td<TdProps>`
  max-width: 512px;
  padding: ${({ padding }) => (padding ? `8px ${padding}px` : `${padding}px`)};
  border-bottom: 0;

  text-align: ${({ collapseComponent }) =>
    !collapseComponent ? 'center' : 'start'};

  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;

  border-color: ${({ theme }) => transparentize(0.8, theme.colors.primary)};
  color: ${({ theme }) => theme.colors.darkText};

  ${({ isBackupBatteryColumn }) =>
    isBackupBatteryColumn &&
    css`
      @media (max-width: 1366px) {
        padding: 0 8px;
      }
    `}

  &:not(:last-child) {
    border-right-width: ${({ firstElement }) =>
      !firstElement ? 'thin' : 'none'};
  }

  > svg {
    border-radius: 50%;
    transform: ${({ isCollapse }) =>
      isCollapse ? 'rotate(0deg)' : 'rotate(180deg)'} !important;
    transition-duration: 500ms;

    :hover {
      background-color: ${({ theme }) =>
        transparentize(0.8, theme.colors.primary)};
    }
  }
`;
