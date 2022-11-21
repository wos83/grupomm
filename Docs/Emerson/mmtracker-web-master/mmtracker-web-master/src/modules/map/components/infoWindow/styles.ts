import { Popup } from 'react-leaflet';
import styled from 'styled-components';

import { Icon } from '@iconify/react';

export const Container = styled(Popup)`
  min-width: 350px;
  justify-content: center;
  align-items: center;
`;

export const Title = styled.h1`
  font-size: 32px;
  text-align: center;
  font-weight: 600;
  color: ${({ theme }) => theme.colors.primary};
`;

export const SubTitle = styled.h2`
  font-size: 16px;
  text-align: center;
  font-weight: 600;
  color: ${({ theme }) => theme.colors.darkText};
`;

export const IconsContent = styled.div`
  width: 100%;
  display: inline-flex;
  justify-content: space-between;
  align-items: center;
`;

export const InfoIcon = styled(Icon)`
  width: 40px;
  font-size: 30px;
  color: #bfc7d4;
`;

export const AddressContent = styled.div`
  width: 100%;
  height: 56px;
  background-color: #c4c4c450;
  border-radius: 8px;
  display: inline-flex;
  align-items: center;
  justify-content: space-between;
`;

export const InfoAddress = styled.span`
  width: 86%;
  font-size: 14px;

  color: #717171;
`;
