export const backupBatteryMask = (value: number | string): string => {
  if (typeof value === 'number') return '';

  const voltage = value
    .replace(/\D/g, '')
    .replace(/(\d{2})(\d)/, '$1.$2')
    .replace(/(\d{2})(\d)/, '$1.$2');

  return `${voltage}v`;
};

export const horimeterMask = (value: number | string): string => {
  if (typeof value === 'number') return '';

  const hour = value
    .replace(/\D/g, '')
    .replace(/(\d{2})(\d)/, '$1:$2')
    .replace(/(\d{2})(\d)/, '$1:$2');

  return `${hour}h`;
};

export const odometerMask = (value: number | string): string => {
  if (typeof value === 'number') return '';

  if (value.length === 5) {
    const tratedValue = value
      .replace(/\D/g, '')
      .replace(/(\d{2})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d)/, '$1.$2');

    return `${tratedValue}m`;
  }

  const tratedValue = value
    .replace(/\D/g, '')
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d)/, '$1.$2');

  return `${tratedValue}m`;
};

export const output1AndOutput2Mask = (value: number | string): string => {
  return value ? 'ON' : 'OFF';
};

export const velocityMask = (value: number | string): string => {
  return `${value} km/h`;
};
