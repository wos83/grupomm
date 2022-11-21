import { InputProps } from './interfaces/input';
import { Input as InputChakra, Label } from './styles';

function Input({
  placeholder,
  backgroundColor = 'white',
  borderRadius = 'lg',
  label,
  size = 'sm',
}: InputProps): JSX.Element {
  return (
    <>
      {label && <Label>{label}</Label>}
      <InputChakra
        _focus="none"
        _hover="none"
        bg={backgroundColor}
        borderRadius={borderRadius}
        placeholder={placeholder}
        size={size}
        variant="filled"
      />
    </>
  );
}

export default Input;
