import * as Highcharts from 'highcharts';
import { DefaultTheme } from 'styled-components';

export const getChartOptions = (theme: DefaultTheme): Highcharts.Options => {
  return {
    credits: { enabled: false },
    tooltip: { enabled: false },
    title: {
      align: 'left',
      floating: true,
      text: 'Resumo das últimas 24h',
      style: {
        color: theme.colors.darkText,
        fontFamily: 'Roboto, sans-serif',
        fontWeight: 'bold',
      },
    },
    legend: {
      align: 'left',
      floating: true,
      verticalAlign: 'middle',
      itemStyle: {
        color: theme.colors.darkText,
        cursor: 'default',
        fontFamily: 'Roboto, sans-serif',
      },
      itemHoverStyle: {
        color: theme.colors.darkText,
        cursor: 'default',
      },
    },
    chart: {
      alignTicks: false,
      width: 415,
      height: 96,
      spacing: [0, 0, 0, 0],
      spacingLeft: 40,
    },
    plotOptions: {
      pie: {
        allowPointSelect: false,
        dataLabels: {
          enabled: true,
          distance: -15,
          format: '{point.y}',
          style: {
            color: theme.colors.black,
            fontWeight: 'bold',
            fontFamily: 'Roboto, sans-serif',
            fontSize: '12',
            textOutline: 'none',
          },
        },
        point: { events: { legendItemClick: () => false } },
        showInLegend: true,
      },
    },
    series: [
      {
        type: 'pie',
        center: ['80%', '50%'],
        enableMouseTracking: false,
        innerSize: '40%',
        size: 96,
        states: { hover: { enabled: false } },
        allowPointSelect: false,
        name: 'Status',
        data: [
          { name: 'Ligado', y: 1, color: theme.colors.success },
          { name: 'Desligado', y: 2, color: theme.colors.alarm },
        ],
      },
    ],
  };
};
