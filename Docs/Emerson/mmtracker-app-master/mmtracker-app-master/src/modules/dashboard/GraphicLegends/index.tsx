import React from 'react';

import {
  Container,
  VehiclesContainer,
  LabelQt,
  LabelName,
  TextQt,
} from './styles';

type ILegendsProps = {
  on: number;
  off: number;
};

const GraphicLegends = ({ on, off }: ILegendsProps): JSX.Element => {
  return (
    <Container>
      <VehiclesContainer>
        <LabelQt>
          <TextQt>{on}</TextQt>
        </LabelQt>
        <LabelName>Ligados</LabelName>
      </VehiclesContainer>
      <VehiclesContainer>
        <LabelQt style={{ backgroundColor: '#F14960' }}>
          <TextQt>{off}</TextQt>
        </LabelQt>
        <LabelName>Desligados</LabelName>
      </VehiclesContainer>
    </Container>
  );
};

export default GraphicLegends;
