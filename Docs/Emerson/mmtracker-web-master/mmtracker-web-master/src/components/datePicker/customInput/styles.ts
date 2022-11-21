import { transparentize } from 'polished';
import styled from 'styled-components';

export const Container = styled.div`
  > input {
    width: 100%;
    height: 32px;
    padding-left: 12px;

    border-radius: 8px;
    border: 2px solid transparent;

    box-shadow: 0px 2px 5px
      ${({ theme }) => transparentize(0.95, theme.colors.primary)};

    &:focus {
      transition-duration: 200ms;
      border: 2px solid ${({ theme }) => theme.colors.primary};
    }
  }
`;
