export type Types = 'alarm' | 'notification';

export interface IconifyIcon {
  body: string;
  left?: number;
  top?: number;
  width?: number;
  height?: number;
  rotate?: number;
  hFlip?: boolean;
  vFlip?: boolean;
}

export interface Icons {
  id: number;
  color: string;
  counter: number;
  icon: IconifyIcon;
  iconSize: number;
  type: Types;
}
