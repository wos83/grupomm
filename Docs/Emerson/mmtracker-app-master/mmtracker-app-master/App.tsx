import React from 'react';
import { ThemeProvider } from 'styled-components/native';

import Routes from './src/routes';
import makeServer from './src/server';
import light from './src/themes/light';

declare global {
  interface Window {
    server: any;
  }
}

if (process.env.NODE_ENV === 'development') {
  if (window.server) {
    window.server.shutdown();
  }
  window.server = makeServer({ environment: 'development' });
}

const App = (): JSX.Element => {
  const theme = light;

  return (
    <ThemeProvider theme={theme}>
      <Routes />
    </ThemeProvider>
  );
};

export default App;
