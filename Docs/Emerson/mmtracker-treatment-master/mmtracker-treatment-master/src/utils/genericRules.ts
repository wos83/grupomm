export const checkCardinalDirection = (data: string, checker: string): string =>
  data === checker ? '-' : '+';

export const convertHexaToDecimal = (
  data: string,
  cardialDirectionChecker: string | undefined,
): string => {
  let convertedToDecimal = '';
  let hexaData = data;
  let signal = '';

  if (cardialDirectionChecker) {
    const signalCharacter = hexaData.charAt(0);
    signal = checkCardinalDirection(signalCharacter, cardialDirectionChecker);
    hexaData = hexaData.substring(1);
  }

  convertedToDecimal = parseInt(hexaData, 16).toString();

  if (cardialDirectionChecker) convertedToDecimal = signal + convertedToDecimal;

  return convertedToDecimal;
};

export const convertChunkHexaToDecimal = (data: string): string => {
  let convertedToDecimal = '';
  const hexaData = data.match(/.{1,2}/g);

  hexaData?.forEach((item) => {
    const decimalData = parseInt(item, 16);
    convertedToDecimal += decimalData.toString().padStart(2, '0');
  });

  return convertedToDecimal;
};

export const divideDataBy = (data: number, divisor: number): number =>
  data / divisor;

export const isIOData = (
  bitPosition: number | undefined,
  bitValueCheck: number | undefined,
  data: string,
  manufacturer: string,
): string => {
  const splitedData = data.split('');

  if (manufacturer === 'ST') return splitedData[bitPosition || 0];

  return +splitedData[bitPosition as keyof typeof splitedData] === bitValueCheck
    ? '1'
    : '0';
};

export const clearPack = (manufacturer: string, pack: string): string => {
  if (manufacturer === 'E3') return pack.substring(0, pack.length - 1);

  return pack;
};
