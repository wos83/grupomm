import styled from 'styled-components/native';

export const Container = styled.View`
  min-width: 350px;
  height: auto;
  background-color: #ffffff;
  justify-content: center;
  align-items: center;
  border-radius: 20px;
  padding: 10px;
`;

export const Title = styled.Text`
  font-size: 32px;
  text-align: center;
  font-weight: 600;
  color: ${({ theme }) => theme.colors.primary};
`;

export const SubTitle = styled.Text`
  font-size: 16px;
  text-align: center;
  font-weight: 600;
  color: ${({ theme }) => theme.colors.darkText};
`;

export const IconsContent = styled.View`
  width: 100%;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
`;

export const InfoIcon = styled.Text`
  width: 40px;
  font-size: 30px;
  color: #bfc7d4;
`;

export const AddressContent = styled.View`
  width: 100%;
  height: 56px;
  background-color: #c4c4c450;
  border-radius: 8px;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  padding-left: 10px;
  margin-top: 10px;
`;

export const InfoAddress = styled.Text`
  padding-left: 5px;
  width: 100%;
  max-width: 300px;
  font-size: 12px;
  flex-shrink: 1;
  color: #717171;
  text-align: center;
`;
