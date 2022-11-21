import { transparentize } from 'polished';
import styled from 'styled-components';

import { Input as InputChakra } from '@chakra-ui/react';

export const Label = styled.h1`
  margin-bottom: 2px;
  color: ${({ theme }) => theme.colors.darkText};

  font-size: 16px;
  font-weight: 500;
`;

export const Input = styled(InputChakra)`
  box-shadow: 0px 2px 5px
    ${({ theme }) => transparentize(0.95, theme.colors.primary)};

  &:focus {
    border: 2px solid ${({ theme }) => theme.colors.primary};
  }
`;
