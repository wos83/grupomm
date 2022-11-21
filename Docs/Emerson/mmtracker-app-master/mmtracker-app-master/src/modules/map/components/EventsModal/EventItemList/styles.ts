import styled from 'styled-components/native';

type IEventListContainer = {
  stripped: boolean;
};

export const Container = styled.View<IEventListContainer>`
  height: 80px;
  width: 100%;
  background-color: ${({ stripped }) => (stripped ? '#E3E3E3' : '#ffffff')};
  align-items: center;
  flex-direction: row;
  padding-left: 5px;
  padding-right: 5px;
`;

type IIconType = {
  isEmergency: boolean;
};

export const IconContainer = styled.View<IIconType>`
  height: 70px;
  width: 70px;
  border-radius: 35px;
  background-color: ${({ isEmergency }) =>
    isEmergency ? '#DC3535' : '#1071e0'};
  align-items: center;
  justify-content: center;
  margin-right: 10px;
`;

export const InfoContainer = styled.View`
  flex: 1;
  justify-content: center;
`;

export const TitleContent = styled.View`
  width: 100%;
  flex-direction: row;
  align-items: center;
`;

export const LicensePlateText = styled.Text`
  font-size: 16px;
  color: #4d4d4d;
  font-weight: 700;
  margin-right: 3px;
`;

export const EventTitle = styled.Text`
  font-size: 14px;
  color: #1071e0;
  font-weight: 700;
`;

export const EventDescription = styled.Text`
  font-size: 14px;
  color: #959595;
`;
