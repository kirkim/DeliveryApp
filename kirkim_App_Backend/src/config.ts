import dotenv from 'dotenv';
import path from 'path';

dotenv.config();

type Value = string;

function required(key: string, defaultValue?: any): Value {
  const value = process.env[key] || defaultValue;
  if (value == null) {
    throw new Error(`${key} is undefined`);
  }
  return value;
}

const config = {
  host: {
    port: Number(required('HOST_PORT', 4000)),
  },
  bcrypt: {
    saltRounds: parseInt(required('BCRTPY_SALT_ROUNDS', 10)),
  },
  static: {
    url: required('BASE_URL', path.resolve() + '/assets'),
  },
  server: {
    baseUrl: required('SERVER_BASE_URL', 'http://localhost:4000'),
  },
};

export default config;
