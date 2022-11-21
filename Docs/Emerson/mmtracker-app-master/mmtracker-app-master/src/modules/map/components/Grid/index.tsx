import React, { useState } from 'react';
import { Dimensions, Platform } from 'react-native';
import { Shadow } from 'react-native-shadow-2';
import FontAwesome5 from 'react-native-vector-icons/FontAwesome5';
import { useTheme } from 'styled-components';

import truck from '../../../../assets/images/icons/caminhao.png';
import car from '../../../../assets/images/icons/carro.png';
import moto from '../../../../assets/images/icons/moto.png';
import Button from '../../../../components/Button';
import Input from '../../../../components/Input';
import { IDataPosition } from '../../../../interfaces/positions';
import ExpandedView from './ExpandedView';
import {
  backupBatteryMask,
  horimeterMask,
  odometerMask,
  output1AndOutput2Mask,
  velocityMask,
} from './masks';
import {
  ButtonWrapper,
  Container,
  Content,
  ContentButton,
  ContentData,
  ContentIdentifier,
  ContentImage,
  ContentSearch,
  DataRow,
  HeaderList,
  Icon,
  Image,
  List,
  Plate,
  shadows,
  Surname,
  Text,
} from './styles';

const images = {
  truck,
  car,
  moto,
};

const gridSubItems = [
  'backupBattery',
  'horimeter',
  'odometer',
  'output1',
  'output2',
  'speed',
];

type IGridProps = {
  dataPositions: Array<IDataPosition>;
};

const Grid = ({ dataPositions = [] }: IGridProps): JSX.Element => {
  const theme = useTheme();

  const [isGridExpand, setIsGridExpand] = useState(false);
  const [isGridMinimized, setIsGridMinimized] = useState(false);

  const { height } = Dimensions.get('window');

  const getIcons = (field: string, value: string | number | boolean) => {
    console.log(field);

    const icons = {
      output1: {
        icon: 'lock',
        color: value ? theme.colors.success : theme.colors.alarm,
      },
      output2: {
        icon: 'volume-up',
        color: value ? theme.colors.success : theme.colors.alarm,
      },
      speed: { icon: 'tachometer-alt', color: theme.colors.primary },
      odometer: { icon: 'road', color: theme.colors.primary },
      horimeter: { icon: 'clock', color: theme.colors.primary },
      backupBattery: { icon: 'car-battery', color: theme.colors.primary },
    };

    return icons[field as keyof typeof icons];
  };

  const getMasks = (field: string, value: number | string | boolean) => {
    const currentValue = typeof value === 'boolean' ? '' : value;

    console.log(currentValue);

    const masks = {
      output1: output1AndOutput2Mask(currentValue),
      output2: output1AndOutput2Mask(currentValue),
      speed: velocityMask(currentValue),
      odometer: odometerMask(currentValue),
      horimeter: horimeterMask(currentValue),
      backupBattery: backupBatteryMask(currentValue),
    };

    return masks[field as keyof typeof masks];
  };

  const getMinWidthDataRow = (index: number) => {
    const widthAndroid = index < 3 ? 104 : 112;

    const widthIOs = index < 3 ? 93 : 104;

    return Platform.OS === 'ios' ? widthIOs : widthAndroid;
  };

  const handleExpand = () => {
    if (isGridMinimized) return;

    setIsGridExpand((current) => !current);
    setIsGridMinimized(false);
  };

  const handleMinimize = () => {
    setIsGridMinimized((current) => !current);
    setIsGridExpand(false);
  };

  return (
    <Container
      gridExpanded={isGridExpand}
      gridMinimized={isGridMinimized}
      heightDevice={height}>
      <Shadow {...shadows.headerList}>
        <HeaderList>
          <ContentSearch>
            <Input border iconName="search" placeholder="Pesquisar" />
          </ContentSearch>
          <ButtonWrapper>
            <ContentButton>
              <Button
                onPress={handleExpand}
                disabled={isGridMinimized}
                iconColor={theme.colors.white}
                iconName="chevron-up"
                iconSize={20}
                rotation={isGridExpand}
                title="Expand"
              />
            </ContentButton>
            <ContentButton>
              <Button
                onPress={handleMinimize}
                iconColor={theme.colors.white}
                iconName={
                  !isGridMinimized ? 'window-minimize' : 'window-maximize'
                }
                iconSize={20}
                title="Minimize"
              />
            </ContentButton>
          </ButtonWrapper>
        </HeaderList>
      </Shadow>
      <List showsVerticalScrollIndicator={false}>
        {dataPositions.map((item) => (
          <Shadow key={item.licensePlate} {...shadows.card}>
            <Content>
              <ContentImage>
                <Image source={images[item.iconType as keyof typeof images]} />
              </ContentImage>
              <ContentIdentifier>
                <Plate>{item.licensePlate}</Plate>
                <Surname>{item.label}</Surname>
              </ContentIdentifier>
              <ContentData>
                {gridSubItems.map((itemRow, index) => {
                  const value =
                    itemRow === 'backupBattery'
                      ? item.backupBattery.voltage
                      : (item[itemRow as keyof typeof item] as
                          | string
                          | number
                          | boolean);

                  return (
                    <DataRow key={index} minWidth={getMinWidthDataRow(index)}>
                      <Icon>
                        <FontAwesome5
                          size={14}
                          color={getIcons(itemRow, value).color}
                          name={getIcons(itemRow, value).icon}
                        />
                      </Icon>
                      <Text>{getMasks(itemRow, value)}</Text>
                    </DataRow>
                  );
                })}
              </ContentData>
              <ExpandedView />
            </Content>
          </Shadow>
        ))}
      </List>
    </Container>
  );
};

export default Grid;
