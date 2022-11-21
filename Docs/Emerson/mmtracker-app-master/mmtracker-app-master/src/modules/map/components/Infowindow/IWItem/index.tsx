import React from 'react';
import FontAwesome5 from 'react-native-vector-icons/FontAwesome5';

import { Container, TextInfo } from './styles';

type IIWItemProps = {
  icon: string;
  value: string;
  fontSize?: number;
};

const IWItem = (item: IIWItemProps): JSX.Element => {
  const { icon, value, fontSize } = item;

  return (
    <Container>
      <FontAwesome5 size={14} color="#788292" name={icon} />
      <TextInfo fontSize={fontSize}>{value}</TextInfo>
    </Container>
  );
};

export default IWItem;
