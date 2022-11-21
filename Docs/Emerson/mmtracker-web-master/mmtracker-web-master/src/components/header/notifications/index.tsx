import car from '../../../assets/icons/carro.png';
import { Types } from '../interfaces/header';
import {
  Body,
  ContentImages,
  ContentModal,
  ContentNotifications,
  Overlay,
  Row,
} from './styles';

interface INotifications {
  onClose: () => void;
  isOpen: boolean;
  type: Types;
}

const data = [
  {
    local:
      'R. MAL. HENRIQUE BATISTA DUFFLES TEIXEIRA LOTT, 279 - VILA MARINGA, JUNDIAÍ - SP, 13210-057',
    plate: 'ABC1234',
    surname: 'Caminhão de entregas',
    violation: 'Ultrapassou limite de velocidade',
  },
  {
    local: 'R. MARQUÊS DE POMBAL, 641 - JARDIM ALTEROSA, BETIM - MG, 32670-706',
    plate: 'ABC1235',
    surname: 'Uber',
    violation: 'Fora de rota',
  },
  {
    local:
      'R. MAL. HENRIQUE BATISTA DUFFLES TEIXEIRA LOTT, 279 - VILA MARINGA, JUNDIAÍ - SP, 13210-057',
    plate: 'ABC1236',
    surname: 'Caminhão de entregas',
    violation: 'Ultrapassou limite de velocidade',
  },
  {
    local:
      'R. MAL. HENRIQUE BATISTA DUFFLES TEIXEIRA LOTT, 279 - VILA MARINGA, JUNDIAÍ - SP, 13210-057',
    plate: 'ABC1234',
    surname: 'Caminhão de entregas',
    violation: 'Ultrapassou limite de velocidade',
  },
  {
    local: 'R. MARQUÊS DE POMBAL, 641 - JARDIM ALTEROSA, BETIM - MG, 32670-706',
    plate: 'ABC1235',
    surname: 'Uber',
    violation: 'Fora de rota',
  },
  {
    local:
      'R. MAL. HENRIQUE BATISTA DUFFLES TEIXEIRA LOTT, 279 - VILA MARINGA, JUNDIAÍ - SP, 13210-057',
    plate: 'ABC1236',
    surname: 'Caminhão de entregas',
    violation: 'Ultrapassou limite de velocidade',
  },
];

function Notifications({ onClose, isOpen, type }: INotifications): JSX.Element {
  return (
    <>
      <Overlay onClick={onClose} isVisible={isOpen} />
      <ContentModal isVisible={isOpen}>
        <Body>
          {data.map((item, index) => (
            <Row key={index}>
              <ContentImages warningType={type}>
                <div>
                  <img src={car} alt="icon" style={{ height: 64, width: 64 }} />
                </div>
              </ContentImages>
              <ContentNotifications warningType={type}>
                <div>
                  <strong>
                    {item.plate} - {item.surname}
                  </strong>
                </div>
                <strong>{item.violation}</strong>
                <h6>{item.local}</h6>
              </ContentNotifications>
            </Row>
          ))}
        </Body>
      </ContentModal>
    </>
  );
}

export default Notifications;
