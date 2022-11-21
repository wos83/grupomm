import { useState, useRef } from 'react';
import { NavLink } from 'react-router-dom';

import { LARGE_ICON_SIZE, MAX_WIDHT_MOBILE } from '../../constants';
import { Icon, iconCog, iconLock, iconMap, iconReports } from './icons-imports';
import {
  Container,
  ContentCogIcon,
  ContentIcon,
  ContentIcons,
  ContentLogo,
  SelectedPage,
} from './styles';

function Sidebar(): JSX.Element {
  const refSelectedPage = useRef<HTMLDivElement>(null);

  const [selectedPosition, setSelectedPosition] = useState(5);

  const icons = [
    {
      id: 1,
      data: iconMap,
      height: LARGE_ICON_SIZE,
      to: '/mmtracker/map',
      width: LARGE_ICON_SIZE,
    },
    {
      id: 2,
      data: iconReports,
      height: LARGE_ICON_SIZE,
      to: '/mmtracker/reports',
      width: LARGE_ICON_SIZE,
    },
    {
      id: 3,
      data: iconLock,
      height: LARGE_ICON_SIZE,
      to: '/mmtracker/commands',
      width: LARGE_ICON_SIZE,
    },
  ];

  const handleClick = (event: React.MouseEvent<HTMLDivElement>) => {
    const mobile = window.screen.width < MAX_WIDHT_MOBILE;

    setSelectedPosition(
      !mobile ? event.currentTarget.offsetTop : event.currentTarget.offsetLeft,
    );
  };

  return (
    <Container>
      <ContentLogo>mm</ContentLogo>
      <ContentIcons>
        <SelectedPage ref={refSelectedPage} position={selectedPosition} />
        {icons.map((icon) => (
          <ContentIcon key={icon.id} onClick={handleClick}>
            <NavLink to={icon.to}>
              <Icon
                icon={icon.data}
                width={icon.width}
                height={icon.height}
                color="white"
              />
            </NavLink>
          </ContentIcon>
        ))}
      </ContentIcons>
      <ContentCogIcon>
        <ContentIcon>
          <Icon
            icon={iconCog}
            width={LARGE_ICON_SIZE}
            height={LARGE_ICON_SIZE}
            color="white"
          />
        </ContentIcon>
      </ContentCogIcon>
    </Container>
  );
}

export default Sidebar;
