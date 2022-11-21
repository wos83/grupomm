import rules from '../helpers/rules.json';
import { DiscoverString, Rules, StringTypes } from '../interfaces/Rules';

export const getFirmware = (data: string): string => {
  const firmwareField = data.substr(0, 2) === 'ST' ? 3 : 2;

  return data.split(';')[firmwareField];
};

export const getDeviceModelByFirmware = (firmwareVersion: string): string => {
  // Buscar em uma tabela do banco ou JSON as versões de firmware / modelo de rastreador

  return firmwareVersion === '318' ? 'ST340' : '';
};

export const getProtocolType = (data: string): string => data.substr(0, 5);

export const getStringRuleSuntech = (
  data: string,
  getStringTypeRules: DiscoverString,
  separator: string,
  stringTypes: Array<StringTypes>,
): StringTypes | undefined => {
  const { fieldToCheck = 0, initialBit = 0, finalBit = 0 } = getStringTypeRules;

  const stringType = data
    .split(separator)
    [fieldToCheck].substr(initialBit, finalBit);

  return stringTypes.find((item) => item.type === stringType);
};

export const getRulesSuntech = (
  data: string,
  manufacturer: string,
): Rules | undefined => {
  const firmwareVersion = getFirmware(data);
  const deviceModel = firmwareVersion
    ? getDeviceModelByFirmware(firmwareVersion)
    : '';

  if (deviceModel)
    return rules.find(
      (item: Rules) =>
        item.manufacturer === manufacturer &&
        item.deviceModels.includes(deviceModel),
    );

  const protocolType = getProtocolType(data);

  return rules.find(
    (item: Rules) =>
      item.manufacturer === manufacturer && item.protocolType === protocolType,
  );
};
