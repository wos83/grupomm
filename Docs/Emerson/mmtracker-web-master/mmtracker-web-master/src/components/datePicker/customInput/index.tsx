import { ForwardedRef, forwardRef } from 'react';

import { Container } from './styles';

const CustomInput = forwardRef(
  (
    props: React.HTMLProps<HTMLInputElement>,
    ref: ForwardedRef<HTMLInputElement>,
  ): JSX.Element => {
    return (
      <Container>
        <input ref={ref} {...props} />
      </Container>
    );
  },
);

export default CustomInput;
