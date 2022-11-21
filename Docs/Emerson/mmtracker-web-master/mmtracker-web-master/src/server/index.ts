import {
  createServer,
  Factory,
  Model,
  Registry,
  RestSerializer,
  Server,
} from 'miragejs';
import { AnyFactories, ModelDefinition } from 'miragejs/-types';

type IMakeServer = Server<
  Registry<
    {
      user: ModelDefinition<Record<string, unknown>>;
      position: ModelDefinition<Record<string, unknown>>;
    },
    AnyFactories
  >
>;

const makeServer = ({ environment = 'test' } = {}): IMakeServer => {
  const server = createServer({
    environment,

    models: {
      user: Model,
      position: Model,
    },

    seeds(srv) {
      srv.create('user');
      srv.create('position');
    },

    serializers: {
      user: RestSerializer.extend({ embed: true }),
      position: RestSerializer.extend({ embed: true }),
    },

    factories: {
      user: Factory.extend({
        name: 'test',
      }),
      position: Factory.extend({
        data: [
          {
            deviceId: '123456789',
            latitude: -23.329134,
            longitude: -46.725234,
            speed: 50,
            odometer: '15912121',
            mainBattery: '12.6',
            backupBattery: { voltage: '3.1', percent: 100 },
            output1: true,
            output2: false,
            gpsFix: true,
            licensePlate: 'ABC1234',
            date: '08-22-2021 21:30:14',
            ignition: true,
            address:
              'ESTR. DR. MIGUEL VIÊIRA FERREIRA, 621 - JARDIM PLANALTO, CARAPICUÍBA - SP, 06361-120 À 3.1 km de MARCIA DE OLIVEIRA PERES',
          },
          {
            deviceId: '523523222',
            latitude: -23.328449,
            longitude: -46.723519,
            speed: 80,
            odometer: '112',
            mainBattery: '8.6',
            backupBattery: { voltage: '2.1', percent: 25 },
            output1: false,
            output2: false,
            gpsFix: true,
            licensePlate: 'DXA1212',
            date: '08-14-2021 10:12:14',
            ignition: false,
            address:
              'ESTR. DR. MIGUEL VIÊIRA FERREIRA, 621 - JARDIM PLANALTO, CARAPICUÍBA - SP, 06361-120 À 3.1 km de MARCIA DE OLIVEIRA PERES',
          },
          {
            deviceId: '123111222',
            latitude: -23.3330004,
            longitude: -46.7267711,
            speed: 80,
            odometer: '112',
            mainBattery: '8.6',
            backupBattery: { voltage: '4.1', percent: 50 },
            output1: false,
            output2: false,
            gpsFix: true,
            licensePlate: 'TST0000',
            date: '08-12-2021 10:12:14',
            ignition: false,
            address:
              'R. MAL. HENRIQUE BATISTA DUFFLES TEIXEIRA LOTT, 279 - VILA MARINGA, JUNDIAÍ - SP, 13210-057 À 23.8 km de VANDERLEY DE SOUZA ALIMENTOS (Nene)',
          },
          {
            deviceId: '141414141',
            latitude: -23.3026562,
            longitude: -46.73735081,
            speed: 80,
            odometer: '112',
            mainBattery: '8.6',
            backupBattery: { voltage: '0', percent: 20 },
            output1: false,
            output2: false,
            gpsFix: true,
            licensePlate: 'TST1111',
            date: '08-14-2021 10:12:14',
            ignition: false,
            address:
              'ESTR. DR. MIGUEL VIÊIRA FERREIRA, 621 - JARDIM PLANALTO, CARAPICUÍBA - SP, 06361-120 À 3.1 km de MARCIA DE OLIVEIRA PERES',
          },
          {
            deviceId: '101010101',
            latitude: -23.5809321,
            longitude: -46.6645903,
            speed: 80,
            odometer: '112',
            mainBattery: '8.6',
            backupBattery: { voltage: '2.4', percent: 24 },
            output1: false,
            output2: false,
            gpsFix: true,
            licensePlate: 'TST2222',
            date: '08-08-2021 10:12:14',
            ignition: false,
            address:
              'ESTR. DR. MIGUEL VIÊIRA FERREIRA, 621 - JARDIM PLANALTO, CARAPICUÍBA - SP, 06361-120 À 3.1 km de MARCIA DE OLIVEIRA PERES',
          },
          {
            deviceId: '151515151',
            latitude: -23.563242,
            longitude: -46.613488,
            speed: 80,
            odometer: '112',
            mainBattery: '8.6',
            backupBattery: { voltage: '2.4', percent: 64 },
            output1: false,
            output2: false,
            gpsFix: true,
            licensePlate: 'DXA1212',
            date: '08-13-2021 10:12:14',
            ignition: false,
            address:
              'ESTR. DR. MIGUEL VIÊIRA FERREIRA, 621 - JARDIM PLANALTO, CARAPICUÍBA - SP, 06361-120 À 3.1 km de MARCIA DE OLIVEIRA PERES',
          },
          {
            deviceId: '171717171',
            latitude: -22.898085,
            longitude: -47.052297,
            speed: 80,
            odometer: '112',
            mainBattery: '8.6',
            backupBattery: { voltage: '2.4', percent: 32 },
            output1: false,
            output2: false,
            gpsFix: true,
            licensePlate: 'DXA1212',
            date: '07-29-2021 10:12:14',
            ignition: false,
            address:
              'R. MAL. HENRIQUE BATISTA DUFFLES TEIXEIRA LOTT, 279 - VILA MARINGA, JUNDIAÍ - SP, 13210-057 À 23.8 km de VANDERLEY DE SOUZA ALIMENTOS (Nene)',
          },
          {
            deviceId: '222222222',
            latitude: -23.4452087,
            longitude: -51.950696,
            speed: 80,
            odometer: '112',
            mainBattery: '8.6',
            backupBattery: { voltage: '2.4', percent: 0 },
            output1: false,
            output2: false,
            gpsFix: true,
            licensePlate: 'DXA1212',
            date: '08-21-2021 10:12:14',
            ignition: false,
            address:
              'ESTR. DR. MIGUEL VIÊIRA FERREIRA, 621 - JARDIM PLANALTO, CARAPICUÍBA - SP, 06361-120 À 3.1 km de MARCIA DE OLIVEIRA PERES',
          },
        ],
        tableColumns: [
          { path: 'licensePlate', name: 'Placa' },
          { path: 'date', name: 'Data' },
          { path: 'odometer', name: 'Odômetro' },
          { path: 'latitude', name: 'Latitude' },
          { path: 'longitude', name: 'Longitude' },
          { path: 'speed', name: 'Velocidade' },
          { path: 'backupBattery', name: 'Bateria backup' },
          { path: 'address', name: 'Endereço' },
        ],
      }),
    },

    routes() {
      this.get('/users', (schema) => {
        return schema.db.users;
      });

      this.post('/login', (schema, request) => {
        const { username } = JSON.parse(request.requestBody);

        return { status: username === 'test' ? 'success' : 'error' };
      });

      this.get('/getVehiclePositions', (schema) => {
        return schema.db.positions;
      });
    },
  });

  return server;
};

export default makeServer;
