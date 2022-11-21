import React, { useEffect, useState } from 'react';
import { StatusBar } from 'react-native';

import ButtonElevated from '../../components/ButtonElevated';
import { IDataEvent } from '../../interfaces/events';
import { IDataPosition } from '../../interfaces/positions';
import EventsService from '../../services/events';
import VehicleService from '../../services/vehicles';
import EventsModal from './components/EventsModal';
import Grid from './components/Grid';
import MapContent from './components/MapContent';
import { Container } from './styles';

const Map = (): JSX.Element => {
  const [eventsModalVisible, setEventsModalVisible] = useState(false);
  const [eventsData, setEventsData] = useState<Array<IDataEvent>>([]);
  const [vehiclesData, setVehiclesData] = useState<Array<IDataPosition>>([]);

  useEffect(() => {
    (async () => {
      const { data } = await EventsService.getAllEvents();

      setEventsData(data[0].data);
    })();
  }, []);

  useEffect(() => {
    (async () => {
      const { data } = await VehicleService.getVehiclePositions();

      setVehiclesData(data[0].data);
    })();
  }, []);

  return (
    <Container>
      <StatusBar
        barStyle="dark-content"
        backgroundColor="transparent"
        translucent
      />
      <Grid dataPositions={vehiclesData} />
      <MapContent dataPositions={vehiclesData} />
      <ButtonElevated
        onPress={() => console.warn('LEFT')}
        iconName="settings"
        side="left"
      />
      <ButtonElevated
        onPress={() => setEventsModalVisible(!eventsModalVisible)}
        iconName="bell"
        side="right"
      />
      <EventsModal
        isVisible={eventsModalVisible}
        onModalHide={() => setEventsModalVisible(false)}
        eventsList={eventsData}
      />
    </Container>
  );
};

export default Map;
