import { transparentize } from 'polished';
import styled, { css } from 'styled-components';

import { Table as TableChakra, Tr as TrChakra } from '@chakra-ui/react';

export const Container = styled.div`
  background-color: ${({ theme }) => theme.colors.white};
  border-radius: 32px 32px 0 0;
  box-shadow: 0px 2px 5px
    ${({ theme }) => transparentize(0.95, theme.colors.primary)};
  overflow: scroll;
  transition-duration: 500ms;
  width: calc(100vw - 120px);
  z-index: 10;

  @media (max-width: 480px) {
    width: 100%;
  }

  ::-webkit-scrollbar-corner {
    background-color: transparent;
  }

  ::-webkit-scrollbar-track {
    margin-top: 40.5px;
  }
`;

export const Table = styled(TableChakra)`
  background-color: ${({ theme }) => theme.colors.white};
`;

export const Th = styled.th`
  background-color: ${({ theme }) => theme.colors.white};
  color: ${({ theme }) => theme.colors.primary};
  padding: 12px 20px;
  position: sticky;
  text-align: center;
  top: 0px;
  white-space: nowrap;
  z-index: 10;
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
  border-bottom: 0;
  border-color: ${({ theme }) => transparentize(0.8, theme.colors.primary)};
  color: ${({ theme }) => theme.colors.darkText};
  max-width: 512px;
  overflow: hidden;
  padding: ${({ padding }) => (padding ? `8px ${padding}px` : `${padding}px`)};
  text-align: ${({ collapseComponent }) =>
    !collapseComponent ? 'center' : 'start'};
  text-overflow: ellipsis;
  white-space: nowrap;

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
