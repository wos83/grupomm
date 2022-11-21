import styled from 'styled-components/native';

export const Container = styled.View`
  width: 33%;
  align-items: center;
`;

export const InfoIcon = styled.View`
  font-size: 30px;
  color: #bfc7d4;
`;

type ITextInfoProps = {
  fontSize?: number;
};

export const TextInfo = styled.Text<ITextInfoProps>`
  font-weight: bold;
  font-size: ${({ fontSize }) => fontSize || 14}px;

  margin-left: 4px;
  color: #788292;
`;
