'use strict';
import express, { Request, Response, NextFunction, ErrorRequestHandler } from 'express';
import morgan from 'morgan';
import config from './config.js';
import boardRouter from './router/boardRouter.js';
import globalRouter from './router/globalRouter.js';
import userRouter from './router/userRouter.js';
import cors from 'cors';

const app = express();
const PORT = config.host.port;

app.use(morgan('dev'));
app.use(cors());
app.use('/', globalRouter);
app.use('/board', boardRouter);
app.use('/user', userRouter);

app.use((_req: Request, res: Response, _next: NextFunction) => {
  return res.sendStatus(404);
});

app.use((error: ErrorRequestHandler, _req: Request, res: Response, _next: NextFunction) => {
  console.error(error);
  return res.sendStatus(500);
});

app.listen(PORT, () => console.log(`success connect server🌈 http://localhost:${PORT}`));
