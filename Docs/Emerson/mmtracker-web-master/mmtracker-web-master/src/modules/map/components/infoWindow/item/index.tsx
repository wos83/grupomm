import { IconifyIcon } from '../../../../../components/header/interfaces/header';
import { Container, TextInfo, InfoIcon } from './styles';

type IIWItemProps = {
  icon: IconifyIcon;
  value: string;
  fontSize?: number;
};

function IWItem(item: IIWItemProps): JSX.Element {
  const { icon, value, fontSize } = item;
  return (
    <Container>
      <InfoIcon icon={icon} />
      <TextInfo fontSize={fontSize}>{value}</TextInfo>
    </Container>
  );
}

export default IWItem;
