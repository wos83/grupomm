import rules from '../helpers/rules.json';
import { DiscoverString, Rules, StringTypes } from '../interfaces/Rules';

export const getDeviceModelByFirmware = (): string => {
  return 'E3';
};

export const getProtocolType = (): string => 'E3';

export const getStringRuleE3 = (
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

export const getRulesE3 = (
  data: string,
  manufacturer: string,
): Rules | undefined => {
  const deviceModel = getDeviceModelByFirmware();

  if (deviceModel)
    return rules.find(
      (item: Rules) =>
        item.manufacturer === manufacturer &&
        item.deviceModels.includes(deviceModel),
    );

  const protocolType = getProtocolType();

  return rules.find(
    (item: Rules) =>
      item.manufacturer === manufacturer && item.protocolType === protocolType,
  );
};
