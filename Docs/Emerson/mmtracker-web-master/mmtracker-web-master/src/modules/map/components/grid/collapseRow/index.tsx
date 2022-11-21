import * as Highcharts from 'highcharts';
import HighchartsReact from 'highcharts-react-official';
import { useTheme } from 'styled-components';

import iconReports from '@iconify/icons-clarity/analytics-line';
import iconLock from '@iconify/icons-clarity/lock-line';
import { Icon } from '@iconify/react';

import { MEDIUM_ICON_SIZE } from '../../../../../constants';
import { getChartOptions } from './chart-options';
import {
  ButtonRedirects,
  ContainerCollapse,
  ContentButtons,
  ContentChart,
  ContentCollapse,
  ContentRow,
  Row,
  WraperContent,
} from './styles';

interface ICollapseRow {
  isOpen: boolean;
}

function CollapseRow({ isOpen, ...props }: ICollapseRow): JSX.Element {
  const theme = useTheme();

  const collapseData = [
    { label: 'Odômetro', value: '100.11Km' },
    { label: 'Horímetro', value: '10:00h' },
    { label: 'RPM', value: '3200' },
    { label: 'Marca', value: 'Ford' },
    { label: 'Modelo', value: 'Fiesta' },
    { label: 'Cor', value: 'Branco' },
    { label: 'Motorista', value: 'Emerson' },
    { label: 'CPF', value: '123.456.789-10' },
    { label: 'Contato', value: '011 - 9911-99111' },
  ];

  return (
    <ContainerCollapse endingHeight={112} in={isOpen}>
      <ContentCollapse>
        <ContentButtons>
          <ButtonRedirects variant="commands">
            <Icon
              icon={iconLock}
              width={MEDIUM_ICON_SIZE}
              height={MEDIUM_ICON_SIZE}
            />
          </ButtonRedirects>
          <ButtonRedirects variant="reports">
            <Icon
              icon={iconReports}
              width={MEDIUM_ICON_SIZE}
              height={MEDIUM_ICON_SIZE}
            />
          </ButtonRedirects>
        </ContentButtons>
        <ContentChart>
          <HighchartsReact
            highcharts={Highcharts}
            options={getChartOptions(theme)}
            {...props}
          />
        </ContentChart>
        <WraperContent>
          {collapseData.map((item, index) => {
            return (
              <Row key={index}>
                <ContentRow>
                  <strong>{item.label}:</strong>
                  <span>{item.value}</span>
                </ContentRow>
              </Row>
            );
          })}
        </WraperContent>
      </ContentCollapse>
    </ContainerCollapse>
  );
}

export default CollapseRow;
