import {
  SplittedCommand,
  SplittedEvent,
  SplittedPosition,
} from '../interfaces/Package';
import {
  FieldProperties,
  Fields,
  Rules,
  StringTypes,
} from '../interfaces/Rules';
import Packages from '../models/Package';
import CommandService from '../services/CommandService';
import EventService from '../services/EventService';
import PositionService from '../services/PositionService';
import { getRulesE3, getStringRuleE3 } from './e3Rules';
import {
  clearPack,
  convertChunkHexaToDecimal,
  convertHexaToDecimal,
  divideDataBy,
  isIOData,
} from './genericRules';
import { getRulesSuntech, getStringRuleSuntech } from './suntechRules';

const getCurrentRule = (
  manufacturer: string,
  data: string,
): Rules | undefined => {
  const dataRules = {
    ST: getRulesSuntech(data, manufacturer),
    E3: getRulesE3(data, manufacturer),
  };

  return dataRules[manufacturer as keyof typeof dataRules];
};

const getFieldPosition = (rulesFields: Fields, field: string): number =>
  rulesFields[field as keyof typeof rulesFields]?.position || 0;

export const getStringRule = (
  currentRules: Rules,
  data: string,
): StringTypes | undefined => {
  const { discoverStringRule, separator, stringTypes, manufacturer } =
    currentRules;

  const getStringTypeRules = discoverStringRule;

  const stringRule = {
    ST: getStringRuleSuntech(data, getStringTypeRules, separator, stringTypes),
    E3: getStringRuleE3(data, getStringTypeRules, separator, stringTypes),
  };

  return stringRule[manufacturer as keyof typeof stringRule];
};

const treatDate = (date: string): string =>
  `${date.substr(0, 4)}-${date.substr(4, 2)}-${date.substr(6, 2)}`;

const treatTime = (time: string): string =>
  `${time.substr(0, 2)}:${time.substr(2, 2)}:${time.substr(4, 2)}`;

const treatField = (
  fieldProps: FieldProperties | undefined,
  data: string,
  manufacturer: string,
): string => {
  if (!fieldProps || Object.keys(fieldProps).length <= 1) return data;

  let currentData = data;

  if (fieldProps.isHexa)
    currentData = convertHexaToDecimal(
      currentData,
      fieldProps.checkCardinalDirection,
    );

  if (fieldProps.isChunkHexa)
    currentData = convertChunkHexaToDecimal(currentData);

  if (fieldProps.divideBy)
    currentData = divideDataBy(+currentData, fieldProps.divideBy).toString();

  if (fieldProps.isCheckBit)
    currentData = isIOData(
      fieldProps.bitPosition,
      fieldProps.bitValueCheck,
      currentData,
      manufacturer,
    );

  if (fieldProps.isDate)
    currentData = treatDate(`${(fieldProps.prevYear || '') + currentData}`);

  if (fieldProps.isTime) currentData = treatTime(currentData);

  return currentData;
};

export const treatPack = async (data: Packages): Promise<void> => {
  const { manufacturer, pack } = data;

  const cleanPack = clearPack(manufacturer, pack);

  const currentRules = getCurrentRule(manufacturer, cleanPack);

  if (!currentRules) return;

  const { fields, name, type } = {
    ...getStringRule(currentRules, cleanPack),
  };

  if (!fields || !name) return;

  const splittedData = cleanPack.split(currentRules.separator);

  const mountedObject = Object.keys(fields).reduce(
    (
      newObj:
        | SplittedCommand
        | SplittedEvent
        | SplittedPosition
        | Record<string, never>,
      value: string,
    ) => {
      const parameter = newObj;
      parameter[value as keyof typeof newObj] = treatField(
        fields[value as keyof typeof fields],
        splittedData[getFieldPosition(fields, value)],
        manufacturer,
      );
      return parameter;
    },
    {},
  );

  switch (name) {
    case 'event':
      await EventService.execute(mountedObject as SplittedEvent, type);
      break;
    case 'command_response':
      await CommandService.execute(mountedObject as SplittedCommand);
      break;
    case 'position':
    default:
      await PositionService.execute(mountedObject as SplittedPosition);
  }
};
