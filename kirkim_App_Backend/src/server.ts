import express, { ErrorRequestHandler, NextFunction, Request, Response } from 'express';
import morgan from 'morgan';
import config from './config.js';
import cors from 'cors';
import userRouter from './router/userRouter.js';

const server = express();
const PORT = config.host.port;

server.use(morgan('dev'));
server.use(cors());
server.use(express.json());
// server.use(express.urlencoded({ extended: true }));
server.use('/user', userRouter);

server.use((_req: Request, res: Response, _next: NextFunction) => {
  return res.sendStatus(404);
});

server.use((error: ErrorRequestHandler, _req: Request, res: Response, _next: NextFunction) => {
  console.error(error);
  return res.sendStatus(500);
});

server.listen(PORT, () => console.log(`success connect server✨ http://localhost:${PORT}`));
