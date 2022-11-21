import styled from 'styled-components';

import { Flex } from '@chakra-ui/react';
import { Icon } from '@iconify/react';

export const Container = styled(Flex)`
  width: 33%;
  align-items: center;
`;

export const InfoIcon = styled(Icon)`
  font-size: 30px;
  color: #bfc7d4;
`;

type ITextInfoProps = {
  fontSize?: number;
};

export const TextInfo = styled.span<ITextInfoProps>`
  font-weight: bold;
  font-size: ${({ fontSize }) => fontSize || 14}px;

  margin-left: 4px;
  color: #788292;
`;
