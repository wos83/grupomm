import Button from '../../components/button';
import Dropdown from '../../components/dropdown';
import Input from '../../components/input';
import VehicleList from '../../components/vehicleList';
import { IHistoricCommands } from '../../interfaces/commands';
import { vehicles } from '../reports/components/filters';
import Grid from './components/grid';
import {
  CommandsHistoric,
  Container,
  ContentGrid,
  Filters,
  InputWrapper,
  Parameters,
  Title,
} from './styles';

const tableColums = [
  { path: 'licensePlate', name: 'Placa' },
  { path: 'command', name: 'Comando' },
  { path: 'requestDate', name: 'Data de solicitação' },
  { path: 'sendDate', name: 'Data de envio' },
  { path: 'confirmationDate', name: 'Data de confirmação' },
];

const data: Array<IHistoricCommands> = [
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
  {
    command: 'Bloqueio',
    confirmationDate: '08-21-2021 10:12:14',
    licensePlate: 'ABC1234',
    requestDate: '08-21-2021 10:12:14',
    sendDate: '08-21-2021 10:12:14',
  },
];

function Commands(): JSX.Element {
  return (
    <Container>
      <Title>
        <b>Comandos</b>
      </Title>
      <Filters>
        <div>
          <VehicleList vehicles={vehicles} maxHeight={296} />
        </div>
        <div>
          <Dropdown label="Comando:" placeholder="Selecione" />
        </div>
        <Parameters>
          <div>
            <b>Parâmetros:</b>
          </div>
          <div>
            <InputWrapper>
              <Input placeholder="IP do servidor" />
            </InputWrapper>
            <InputWrapper>
              <Input placeholder="Porta do servidor" />
            </InputWrapper>
            <InputWrapper>
              <Input placeholder="Tempo de envio" />
            </InputWrapper>
            <InputWrapper>
              <Input placeholder="Envio parado" />
            </InputWrapper>
            <InputWrapper>
              <Input placeholder="Limite de velocidade" />
            </InputWrapper>
            <InputWrapper>
              <Input placeholder="Tempo de envio" />
            </InputWrapper>
          </div>
          <div>
            <Button color="green" label="Enviar" padding={24} />
          </div>
        </Parameters>
      </Filters>
      <CommandsHistoric>
        <b>Histórico de comandos enviados</b>
        <ContentGrid>
          <Grid dataPositions={data} tableColumns={tableColums} />
        </ContentGrid>
      </CommandsHistoric>
    </Container>
  );
}

export default Commands;
