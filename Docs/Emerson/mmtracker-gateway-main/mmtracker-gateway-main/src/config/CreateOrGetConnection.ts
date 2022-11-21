import {
  ConnectionOptions,
  createConnection,
  getConnectionManager,
} from 'typeorm';
import { SnakeNamingStrategy } from 'typeorm-naming-strategies';

const objConnection = {
  name: process.env.POSTGRES_NAME,
  database: process.env.POSTGRES_DATABASE,
  host: process.env.POSTGRES_HOST,
  port: Number(process.env.POSTGRES_PORT) || 5432,
  username: process.env.POSTGRES_USERNAME,
  password: process.env.POSTGRES_PASSWORD,
  type: 'postgres',
  entities: ['./src/models/*.ts'],
  namingStrategy: new SnakeNamingStrategy(),
} as ConnectionOptions;

const CreateOrGetConnection = async (): Promise<void> => {
  try {
    const hasConnection = getConnectionManager().has(
      process.env.POSTGRES_DATABASE || 'postgres',
    );

    if (!hasConnection) {
      await createConnection(objConnection);
    }
  } catch (error) {
    console.warn(error);
    throw error;
  }
};

export default CreateOrGetConnection;
