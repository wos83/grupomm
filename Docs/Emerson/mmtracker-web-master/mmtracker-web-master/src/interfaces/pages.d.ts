export interface IPages {
  path: string;
  dynamicImport: ReactElement<any, any>;
  hasMenu: boolean;
  icon?: string;
  access: string;
  name?: string;
}
