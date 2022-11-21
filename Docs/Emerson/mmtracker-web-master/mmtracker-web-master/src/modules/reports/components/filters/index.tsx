import { useState } from 'react';

import caretLine from '@iconify/icons-clarity/caret-line';

import Button from '../../../../components/button';
import Datepicker from '../../../../components/datePicker';
import Dropdown from '../../../../components/dropdown';
import VehicleList from '../../../../components/vehicleList';
import { SMALL_ICON_SIZE } from '../../../../constants';
import {
  Container,
  Content,
  ContentDateFilter,
  ContentFilterButton,
  ContentReportsType,
  ContentTitle,
  Expand,
} from './styles';

export const vehicles = [
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
  {
    date: '22/08/2021',
    plate: 'ABC1234',
  },
];

function Filters(): JSX.Element {
  const [isExpand, setIsExpand] = useState(false);

  return (
    <>
      <Expand
        heightScreen={document.documentElement.offsetHeight}
        onClick={() => setIsExpand((current) => !current)}
        expanded={isExpand}>
        <Button icon={caretLine} iconSize={SMALL_ICON_SIZE} padding={2} />
      </Expand>
      <Container
        expanded={isExpand}
        heightScreen={document.documentElement.offsetHeight}>
        <Content>
          <ContentTitle>
            <b>Relatórios</b>
          </ContentTitle>
          <ContentDateFilter>
            <div>
              <Datepicker label="Período de:" />
            </div>
            <div>
              <Datepicker label="Período até:" />
            </div>
          </ContentDateFilter>
          <ContentReportsType>
            <Dropdown label="Tipo de relatório:" placeholder="Tipo" />
          </ContentReportsType>
          <VehicleList vehicles={vehicles} />
          <ContentFilterButton>
            <div>
              <Button
                onClick={() => setIsExpand(false)}
                color="green"
                label="SOLICITAR"
              />
            </div>
          </ContentFilterButton>
        </Content>
      </Container>
    </>
  );
}

export default Filters;
