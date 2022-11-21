import React from 'react';
import ReactNativeModal from 'react-native-modal';
import FontAwesome5Icon from 'react-native-vector-icons/FontAwesome5';

import { IDataEvent } from '../../../../interfaces/events';
import EventsItemList from './EventItemList';
import { CloseButton, Container, ModalTitle, ScrollView } from './styles';

interface IEventsModalProps {
  isVisible: boolean;
  onModalHide: () => void;
  eventsList: Array<IDataEvent>;
}

const EventsModal = ({
  isVisible,
  onModalHide,
  eventsList,
}: IEventsModalProps): JSX.Element => {
  return (
    <ReactNativeModal isVisible={isVisible} onBackdropPress={onModalHide}>
      <Container>
        <ModalTitle>Eventos</ModalTitle>
        <CloseButton onPress={onModalHide}>
          <FontAwesome5Icon size={24} color="#1071E0" name="times" />
        </CloseButton>
        <ScrollView>
          {eventsList.map((item, key) => (
            <EventsItemList
              id={key}
              key={key}
              licensePlate={item.licensePlate}
              title={item.title}
              description={item.description}
              iconType={item.iconType}
            />
          ))}
        </ScrollView>
      </Container>
    </ReactNativeModal>
  );
};

export default EventsModal;
