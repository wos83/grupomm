import { Icon } from '@iconify/react';

import { LARGE_ICON_SIZE } from '../../constants';
import { IconifyIcon } from '../header/interfaces/header';
import { ButtonContainer, Text } from './styles';

interface IButton extends React.HTMLAttributes<HTMLButtonElement> {
  color?: 'primary' | 'secundary' | 'green';
  disabled?: boolean;
  icon?: IconifyIcon;
  iconSize?: number;
  label?: string;
  padding?: number;
}

function Button({
  onClick,
  color = 'primary',
  disabled = false,
  icon,
  iconSize = LARGE_ICON_SIZE,
  label,
  padding,
}: IButton): JSX.Element {
  return (
    <ButtonContainer
      onClick={onClick}
      color={color}
      disabled={disabled}
      padding={padding}>
      {icon && <Icon width={iconSize} height={iconSize} icon={icon} />}
      {label && <Text>{label}</Text>}
    </ButtonContainer>
  );
}

export default Button;
