import styled from 'styled-components';

type TagProps = {
  color?: string;
};

export const Tag = styled.div<TagProps>`
  background-color: ${({ color }) => color};
  border-radius: 8px;
  color: ${({ theme }) => theme.colors.white};
  margin-top: 4px;
`;
