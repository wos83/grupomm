import styled from 'styled-components/native';

export const Container = styled.View`
  height: 400px;
  background-color: #fff;
  border-radius: 8px;
  align-items: center;
`;

export const ModalTitle = styled.Text`
  font-size: 32px;
  color: #07458c;
  font-weight: 600;
`;

export const ScrollView = styled.ScrollView`
  width: 100%;
  height: 100%;
`;

export const CloseButton = styled.TouchableOpacity`
  width: 30px;
  height: 30px;
  position: absolute;
  right: 0;
  top: 5px;
`;
