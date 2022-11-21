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
