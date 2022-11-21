import styled from 'styled-components/native';

export const Container = styled.View`
  flex-direction: column;
  height: 100%;
  justify-content: center;
`;

export const VehiclesContainer = styled.View`
  flex-direction: row;
  align-items: center;
  margin-top: 5px;
`;

export const LabelQt = styled.View`
  background-color: #29cb97;
  width: 40px;
  height: 40px;
  border-radius: 4px;
  justify-content: center;
  align-items: center;
`;

export const LabelName = styled.Text`
  font-size: 22px;
  margin-left: 5px;
`;

export const TextQt = styled.Text`
  font-size: 20px;
  color: white;
`;
