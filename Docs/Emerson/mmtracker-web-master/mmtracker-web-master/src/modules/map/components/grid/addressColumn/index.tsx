import { IDataPosition } from '../../../../../interfaces/positions';
import { Content } from './styles';

function AddressColumn({
  data,
  path,
}: {
  data: IDataPosition;
  path: string;
}): JSX.Element {
  return <Content>{data[path as keyof typeof data] as string}</Content>;
}

export default AddressColumn;
