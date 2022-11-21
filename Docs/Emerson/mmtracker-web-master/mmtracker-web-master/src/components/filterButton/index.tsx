import filterVariant from '@iconify/icons-mdi/filter-variant';

import Button from '../button';
import { Container } from './styles';

function FilterButton(): JSX.Element {
  return (
    <Container>
      <Button
        color="secundary"
        icon={filterVariant}
        iconSize={24}
        label="Filtro"
      />
    </Container>
  );
}

export default FilterButton;
