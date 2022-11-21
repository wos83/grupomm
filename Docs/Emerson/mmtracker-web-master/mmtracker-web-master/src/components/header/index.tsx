import { useState } from 'react';

import alarm from '@iconify/icons-mdi/alarm-light-outline';
import notification from '@iconify/icons-mdi/bell-outline';
import { Icon } from '@iconify/react';

import { LARGE_ICON_SIZE } from '../../constants';
import Input from '../input';
import { Icons, Types } from './interfaces/header';
import Notifications from './notifications';
import {
  Container,
  ContentIcon,
  ContentNotifications,
  ContentSearch,
  Counter,
} from './styles';

function Header(): JSX.Element {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [warningType, setWarningType] = useState<Types>('alarm');

  const icons: Array<Icons> = [
    {
      id: 1,
      color: 'white',
      counter: 0,
      icon: alarm,
      iconSize: LARGE_ICON_SIZE,
      type: 'alarm',
    },
    {
      id: 2,
      color: 'white',
      counter: 0,
      icon: notification,
      iconSize: LARGE_ICON_SIZE,
      type: 'notification',
    },
  ];

  const handleClick = (type: Types) => {
    setWarningType(type);
    setIsModalOpen(true);
  };

  const handleModalClose = () => setIsModalOpen(false);

  return (
    <>
      <Container>
        <ContentSearch>
          <Input borderRadius="xl" placeholder="Pesquisar" />
        </ContentSearch>
        <ContentNotifications>
          {icons.map((icon) => (
            <ContentIcon key={icon.id} onClick={() => handleClick(icon.type)}>
              <Icon
                color={icon.color}
                icon={icon.icon}
                height={icon.iconSize}
                width={icon.iconSize}
              />
              <Counter type={icon.type}>{icon.counter}</Counter>
            </ContentIcon>
          ))}
        </ContentNotifications>
      </Container>
      <Notifications
        onClose={handleModalClose}
        isOpen={isModalOpen}
        type={warningType}
      />
    </>
  );
}

export default Header;
