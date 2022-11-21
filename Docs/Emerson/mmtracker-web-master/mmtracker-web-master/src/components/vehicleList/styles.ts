import { transparentize } from 'polished';
import styled from 'styled-components';

export const Container = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;

  > h1 {
    color: ${({ theme }) => theme.colors.darkText};
    font-size: 16px;
    font-weight: 500;
    margin-bottom: 2px;
  }
`;

export const ContentVehicles = styled.div`
  background-color: ${({ theme }) => theme.colors.white};
  border-radius: 8px;
  box-shadow: 0px 2px 5px
    ${({ theme }) => transparentize(0.95, theme.colors.primary)};
  flex: 1;
`;

export const VehicleFilter = styled.div`
  padding: 16px 16px 8px 16px;
`;

type ListProps = {
  maxHeight?: number;
};

export const List = styled.div<ListProps>`
  display: flex;
  flex-wrap: wrap;
  max-height: ${({ maxHeight }) =>
    maxHeight ? `${maxHeight}px` : 'calc(100vh - 456px)'};
  padding: 0 8px 8px 8px;
  overflow: auto;

  ::-webkit-scrollbar-track {
    margin-bottom: 4px;
  }
`;

type VehicleCardProps = {
  selected: boolean;
};

export const VehicleCard = styled.div<VehicleCardProps>`
  align-items: center;
  background-color: ${({ selected, theme }) =>
    selected && theme.colors.primary};
  border: 2px solid ${({ theme }) => theme.colors.primary};
  border-radius: 16px;
  cursor: pointer;
  display: flex;
  height: 80px;
  flex-direction: column;
  justify-content: center;
  margin: 8px;
  flex: 1;
  min-width: 136px;

  > strong {
    color: ${({ selected, theme }) =>
      !selected ? theme.colors.primary : theme.colors.white};
    font-size: 20px;
    line-height: 24px;
  }

  > span {
    color: ${({ selected, theme }) =>
      !selected ? theme.colors.darkText : theme.colors.black};
    font-size: 14px;
    line-height: 24px;
  }

  @media (max-width: 480px) {
    min-width: 128px;
  }
`;
