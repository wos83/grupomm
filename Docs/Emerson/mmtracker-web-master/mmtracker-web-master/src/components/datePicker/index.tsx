import ptBR from 'date-fns/locale/pt-BR';
import { createElement, useState } from 'react';
import DatePicker, { registerLocale } from 'react-datepicker';

import 'react-datepicker/dist/react-datepicker.css';
import CustomInput from './customInput';
import { Label } from './styles';
import './styles.css';

registerLocale('ptBR', ptBR);

function Datepicker({ label }: { label?: string }): JSX.Element {
  const [startDate, setStartDate] = useState(new Date());

  return (
    <>
      {label && <Label>{label}</Label>}
      <DatePicker
        onChange={(date) => setStartDate(date as Date)}
        customInput={createElement(CustomInput)}
        dateFormat="Pp"
        disabledKeyboardNavigation
        formatWeekDay={(nameOfDay) => nameOfDay.substr(0, 1).toUpperCase()}
        locale={ptBR}
        selected={startDate}
        showTimeSelect
        timeCaption="HORAS"
        timeFormat="p"
        timeIntervals={15}
      />
    </>
  );
}

export default Datepicker;
