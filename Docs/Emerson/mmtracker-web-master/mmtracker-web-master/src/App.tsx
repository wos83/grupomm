import { ThemeProvider } from 'styled-components';

import { ChakraProvider } from '@chakra-ui/react';

import Routes from './routes';
import makeServer from './server';
import './themes/global.css';
import light from './themes/light';

makeServer({ environment: 'development' });

export function App(): JSX.Element {
  const theme = light;

  return (
    <ThemeProvider theme={theme}>
      <ChakraProvider>
        <Routes />
      </ChakraProvider>
    </ThemeProvider>
  );
}
