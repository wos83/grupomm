import React from 'react';
import { Dimensions } from 'react-native';
import { BarChart, PieChart } from 'react-native-chart-kit';
import SimpleLineIcons from 'react-native-vector-icons/FontAwesome5';

import GraphicLegends from './GraphicLegends';
import {
  Container,
  NotificationCard,
  CoverEndCard,
  Title,
  Description,
} from './styles';

const Dashboard = (): JSX.Element => {
  const { width } = Dimensions.get('window');

  const data = [
    {
      name: 'Ligados',
      vehicles: 60,
      color: '#29CB97',
      legendFontColor: '#7F7F7F',
      legendFontSize: 30,
    },
    {
      name: 'Desligados',
      vehicles: 40,
      color: '#F14960',
      legendFontColor: '#7F7F7F',
      legendFontSize: 30,
    },
  ];

  const commData = {
    labels: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho'],
    datasets: [
      {
        data: [20, 50, 28, 75, 80, 100],
      },
    ],
  };

  const chartConfig = {
    backgroundGradientFrom: '#fff',
    backgroundGradientFromOpacity: 0,
    backgroundGradientTo: '#eee',
    backgroundGradientToOpacity: 0.5,
    color: (opacity = 1) => `rgba(10, 10, 10, ${opacity})`,
    useShadowColorFromDataset: false,
  };

  return (
    <Container>
      <NotificationCard style={{ elevation: 2 }}>
        <Title>Informativo</Title>
        <Description>Olá!</Description>
        <Description>
          Você possui uma pendência financeira, Normalize seus pagamentos com a
          plataforma.
        </Description>
        <CoverEndCard style={{ elevation: 3 }}>
          <SimpleLineIcons color="#748AA1" name="chevron-left" size={18} />
        </CoverEndCard>
      </NotificationCard>
      <NotificationCard
        style={{
          elevation: 2,
          paddingTop: 0,
          paddingLeft: 0,
          flexDirection: 'row',
        }}>
        <PieChart
          data={data}
          width={200}
          height={120}
          chartConfig={chartConfig}
          accessor="vehicles"
          backgroundColor="transparent"
          paddingLeft="0"
          hasLegend={false}
          style={{ marginLeft: 20 }}
        />
        <GraphicLegends on={104} off={32} />
      </NotificationCard>
      <NotificationCard style={{ elevation: 2, height: 300 }}>
        <Title>Rastreadores ativos</Title>
        <BarChart
          data={commData}
          width={width - 50}
          height={240}
          yAxisLabel=""
          chartConfig={chartConfig}
          yAxisSuffix=""
          fromZero
        />
      </NotificationCard>
    </Container>
  );
};

export default Dashboard;
