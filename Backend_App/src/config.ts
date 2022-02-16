import dotenv from 'dotenv';

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
    port: Number(required('HOST_PORT', 8080)),
  },
};

export default config;
