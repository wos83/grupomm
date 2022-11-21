import { transparentize } from 'polished';
import styled from 'styled-components';

import { Center, Flex } from '@chakra-ui/react';

import LoginInput from './components/input';

export const Container = styled(Flex)`
  width: 80%;
  height: 80%;

  box-shadow: 0px 0px 5px 3px
    ${({ theme }) => transparentize(0.75, theme.colors.black)};
  border-radius: 32px;

  @media (max-width: 900px) {
    width: auto;
    flex-direction: column;
  }
`;

export const ImageContent = styled(Center)`
  background-color: white;

  border-bottom-left-radius: 32px;
  border-top-left-radius: 32px;

  @media (max-width: 900px) {
    height: 30%;
    border-bottom-left-radius: 0px;
    border-top-right-radius: 32px;
  }
`;

export const FormContent = styled(Center)`
  height: 100%;
  width: 444px;
  padding: 80px;
  flex-direction: column;
  background: ${({ theme }) =>
    `radial-gradient(circle, ${theme.gradients.primary.start} 0%, ${theme.gradients.primary.end} 100%)`};

  border-bottom-right-radius: 32px;
  border-top-right-radius: 32px;

  @media (max-width: 900px) {
    height: 70%;
    width: 100%;
    padding: 40px;

    border-top-right-radius: 0px;
    border-bottom-left-radius: 32px;
  }
`;

export const Input = styled(LoginInput)`
  margin: 20px;

  @media (max-width: 900px) {
    margin-top: 10px;
    margin-bottom: 10px;
  }
`;

export const ImageLogo = styled.img`
  margin-bottom: 50px;

  @media (max-width: 900px) {
    margin-bottom: 20px;
  }
`;

export const ImagePaper = styled.img`
  max-height: 100%;
  margin-left: 50px;

  @media (max-width: 900px) {
    margin-left: 0px;
  }
`;

export const ButtonLogin = styled.button`
  width: 200px;
  height: 40px;
  margin-top: 50px;
  background-color: white;
  color: ${({ theme }) => theme.colors.darkText};
  border-radius: 32px;
  box-shadow: 0px 1px 2px
    ${({ theme }) => transparentize(0.5, theme.colors.black)};

  display: flex;
  justify-content: center;
  align-items: center;

  text-align: center;
  font-size: 20px;

  @media (max-width: 900px) {
    margin-top: 10px;
  }
`;
