import { transparentize } from 'polished';
import styled, { css } from 'styled-components';

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
