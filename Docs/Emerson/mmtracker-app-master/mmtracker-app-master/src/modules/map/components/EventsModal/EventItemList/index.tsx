import React from 'react';
import FontAwesome5Icon from 'react-native-vector-icons/FontAwesome5';

import {
  Container,
  IconContainer,
  TitleContent,
  InfoContainer,
  LicensePlateText,
  EventTitle,
  EventDescription,
} from './styles';

interface IEventsModalProps {
  id: number;
  iconType: string;
  licensePlate: string;
  title: string;
  description: string;
}

const EventsItemList = ({
  id,
  iconType,
  licensePlate,
  title,
  description,
}: IEventsModalProps): JSX.Element => {
  return (
    <Container stripped={id % 2 === 0}>
      <IconContainer isEmergency={iconType === 'emergency'}>
        <FontAwesome5Icon
          size={32}
          color="white"
          name={iconType === 'emergency' ? 'exclamation-circle' : 'flag'}
        />
      </IconContainer>
      <InfoContainer>
        <TitleContent>
          <LicensePlateText>{licensePlate}</LicensePlateText>
          <EventTitle>{title}</EventTitle>
        </TitleContent>
        <EventDescription>{description}</EventDescription>
      </InfoContainer>
    </Container>
  );
};

export default EventsItemList;
