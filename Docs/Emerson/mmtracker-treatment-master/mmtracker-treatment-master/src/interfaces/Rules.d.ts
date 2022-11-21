interface FieldProperties {
  position: number;
  bitPosition?: number;
  bitValueCheck?: number;
  checkCardinalDirection?: string;
  divideBy?: number;
  isCheckBit?: boolean;
  isChunkHexa?: boolean;
  isDate?: boolean;
  isHexa?: boolean;
  isTime?: boolean;
  lastItem?: boolean;
  prevYear?: string;
  type?: string;
}

export interface Fields {
  header?: FieldProperties;
  deviceId?: FieldProperties;
  isGPSOn?: FieldProperties;
  fwVersion?: FieldProperties;
  date?: FieldProperties;
  time?: FieldProperties;
  latitude?: FieldProperties;
  longitude?: FieldProperties;
  speed?: FieldProperties;
  direction?: FieldProperties;
  course?: FieldProperties;
  satellite?: FieldProperties;
  odometer?: FieldProperties;
  mainBattery?: FieldProperties;
  backupBattery?: FieldProperties;
  batteryPercent?: FieldProperties;
  ignition?: FieldProperties;
  inputOne?: FieldProperties;
  inputTwo?: FieldProperties;
  inputThree?: FieldProperties;
  outputOne?: FieldProperties;
  outputTwo?: FieldProperties;
  outputMode?: FieldProperties;
}

export interface StringTypes {
  type: string;
  name?: string;
  fields: Fields;
}

export interface DiscoverString {
  fieldToCheck?: number;
  initialBit?: number;
  finalBit?: number;
}

export interface Rules {
  manufacturer: string;
  deviceModels: Array<string>;
  protocolType: string;
  separator: string;
  discoverStringRule: DiscoverString;
  stringTypes: Array<StringTypes>;
}
