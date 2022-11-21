import styled from 'styled-components/native';

export const Container = styled.View`
  width: 100%;
  height: 100%;
  padding: 10px;
  background-color: ${({ theme }) => theme.colors.body};
  align-items: center;
`;

export const NotificationCard = styled.View`
  width: 100%;
  height: 120px;
  background-color: ${({ theme }) => theme.colors.cardBackgroud};
  border-radius: 8px;
  margin-bottom: 10px;
  padding: 16px;
  padding-top: 8px;
`;

export const CoverEndCard = styled.View`
  width: 32px;
  height: 120px;
  position: absolute;
  right: 0;
  background-color: #f5f6fa;
  border-radius: 8px;
  justify-content: center;
  align-items: center;
`;

export const Title = styled.Text`
  font-size: 24px;
`;

export const Description = styled.Text`
  font-size: 15px;
`;
