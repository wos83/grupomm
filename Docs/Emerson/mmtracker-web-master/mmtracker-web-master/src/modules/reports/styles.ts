import styled from 'styled-components';

export const Container = styled.div`
  background-color: ${({ theme }) => theme.colors.white};
  border-radius: 32px 32px 32px 0;
  height: 100%;
  width: 100%;
`;

type ContentGridProps = {
  expanded: boolean;
};

export const ContentGrid = styled.div<ContentGridProps>`
  background-color: ${({ theme }) => theme.colors.white};
  border-radius: ${({ expanded }) =>
    expanded ? '32px 32px 32px 0' : '32px 32px 0 0'}%;
  height: ${({ expanded }) => (expanded ? 100 : 60)}%;
  position: relative;
  transition-duration: 500ms;

  > div:first-child {
    max-height: calc(100% - 48px);
  }
`;

type ExpandGridProps = {
  expanded: boolean;
};

export const ExpandGrid = styled.div<ExpandGridProps>`
  bottom: 8px;
  position: absolute;
  right: 16px;
  width: 32px;

  > button {
    height: 32px;

    > svg {
      transform: ${({ expanded }) =>
        expanded ? 'rotate(0deg)' : 'rotate(-180deg)'} !important;
      transition-duration: 500ms;
    }
  }
`;

type ContentMapProps = {
  gridExpanded: boolean;
};

export const ContentMap = styled.div<ContentMapProps>`
  border-radius: 0 0 32px 0;
  height: ${({ gridExpanded }) => (gridExpanded ? 0 : 40)}%;
  opacity: ${({ gridExpanded }) => (gridExpanded ? 0 : 1)};
  position: relative;
  transition-duration: 500ms;
`;
