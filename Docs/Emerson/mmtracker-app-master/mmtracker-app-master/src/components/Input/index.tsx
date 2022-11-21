import React from 'react';
import FontAwesome from 'react-native-vector-icons/FontAwesome5';
import { useTheme } from 'styled-components';

import { Container, ContentIcon, TextInput } from './styles';

interface IInput {
  border?: boolean;
  iconName?: string;
  placeholder: string;
  value?: string;
}

const Input = ({
  border = false,
  iconName,
  placeholder,
  value,
}: IInput): JSX.Element => {
  const theme = useTheme();

  return (
    <Container border={border}>
      {!!iconName && (
        <ContentIcon>
          <FontAwesome color={theme.colors.lightText} name={iconName} />
        </ContentIcon>
      )}
      <TextInput
        placeholder={placeholder}
        placeholderTextColor={theme.colors.lightText}
        value={value}
      />
    </Container>
  );
};

export default Input;
