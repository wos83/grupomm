/* eslint-disable camelcase */
import { ThemedCssFunction } from 'styled-components';

declare module 'styled-components' {
  interface Margins {
    mt?: number;
    mb?: number;
    ml?: number;
    mr?: number;
  }

  type Color = {
    50: string;
    100: string;
    200: string;
    300: string;
    400: string;
    500: string;
    600: string;
    700: string;
    800: string;
    900: string;
  };
  export interface DefaultTheme {
    colors: {
      primary: string;
      secundary: string;
      alarm: string;
      background: string;
      black: string;
      body: string;
      darkText: string;
      disabled: string;
      menuSelected: string;
      notification: string;
      success: string;
      white: string;
    };
    gradients: {
      primary: { start: string; end: string };
    };
    fonts?: {
      heading: {
        bold: {
          md: ThemedCssFunction;
          xxl: ThemedCssFunction;
          lg: ThemedCssFunction;
          xl: ThemedCssFunction;
        };
        semi_bold: {
          xl: ThemedCssFunction;
          lg: ThemedCssFunction;
          md: ThemedCssFunction;
          sm: ThemedCssFunction;
        };
        regular: {
          lg: ThemedCssFunction;
          md: ThemedCssFunction;
          sm: ThemedCssFunction;
          xs: ThemedCssFunction;
        };
      };
      subtitle: {
        medium: {
          lg: ThemedCssFunction;
          md: ThemedCssFunction;
          xs: ThemedCssFunction;
        };
        regular: {
          xs: ThemedCssFunction;
        };
      };
      body: {
        regular: {
          md: ThemedCssFunction;
          sm: ThemedCssFunction;
          xs: ThemedCssFunction;
          s: ThemedCssFunction;
          m: ThemedCssFunction;
          l: ThemedCssFunction;
          xl: ThemedCssFunction;
          xxl: ThemedCssFunction;
        };
        semi_bold: {
          sm: ThemedCssFunction;
          xs: ThemedCssFunction;
          xxl: ThemedCssFunction;
        };
        bold: {
          xs: ThemedCssFunction;
          s: ThemedCssFunction;
          m: ThemedCssFunction;
          l: ThemedCssFunction;
          xl: ThemedCssFunction;
          xxl: ThemedCssFunction;
        };
      };
      action: {
        semi_bold: {
          md: ThemedCssFunction;
        };
      };
    };
  }
}
