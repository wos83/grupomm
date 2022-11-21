import {
  Input,
  InputGroup,
  InputLeftElement,
  InputRightElement,
} from '@chakra-ui/react';
import { Icon } from '@iconify/react';

import { ILoginInputProps } from '../../interfaces/input';

function LoginInput({
  icon,
  height = 40,
  placeholder,
  className,
  value,
  onChange,
  rightIcon,
}: ILoginInputProps): JSX.Element {
  return (
    <InputGroup size="lg" className={className}>
      <InputLeftElement color="white" fontSize="1.5em" height={`${height}px`}>
        <Icon icon={icon} />
      </InputLeftElement>
      <Input
        height={`${height}px`}
        borderWidth={0}
        borderBottomWidth={1}
        borderBottomRadius={0}
        placeholder={placeholder}
        value={value}
        onChange={onChange}
      />
      {rightIcon && (
        <InputRightElement color="white" fontSize="2em" height={`${height}px`}>
          <Icon icon={rightIcon} />
        </InputRightElement>
      )}
    </InputGroup>
  );
}

export default LoginInput;
