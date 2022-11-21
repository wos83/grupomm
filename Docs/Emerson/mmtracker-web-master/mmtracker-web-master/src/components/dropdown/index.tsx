import { DropdownProps } from './interfaces/dropdown';
import { Select, Label } from './styles';

function Dropdown({
  placeholder,
  backgroundColor = 'white',
  borderRadius = 'lg',
  label,
  size = 'sm',
}: DropdownProps): JSX.Element {
  return (
    <>
      {label && <Label>{label}</Label>}
      <Select
        _focus="none"
        _hover="none"
        bg={backgroundColor}
        borderRadius={borderRadius}
        fontSize={16}
        placeholder={placeholder}
        size={size}
        variant="filled"
      />
    </>
  );
}

export default Dropdown;
