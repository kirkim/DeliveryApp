import express, { ErrorRequestHandler, NextFunction, Request, Response } from 'express';
import morgan from 'morgan';
import config from './config.js';
import cors from 'cors';
import userRouter from './router/userRouter.js';
import bannerRouter from './router/bannerRouter.js';
import deliveryRouter from './router/deliveryRouter.js';
import reviewRouter from './router/reviewRouter.js';

const server = express();
const PORT = config.host.port;
const staticUrl = config.static.url;

server.use(morgan('dev'));
server.use(cors());
server.use(express.json());
server.use(express.static(staticUrl));
// server.use(express.urlencoded({ extended: true }));
server.use('/user', userRouter);
server.use('/banner', bannerRouter);
server.use('/delivery', deliveryRouter);
server.use('/review', reviewRouter);

server.use((_req: Request, res: Response, _next: NextFunction) => {
  return res.sendStatus(404);
});

server.use((error: ErrorRequestHandler, _req: Request, res: Response, _next: NextFunction) => {
  console.error(error);
  return res.sendStatus(500);
});

server.listen(PORT, () => console.log(`success connect server✨ ${config.server.baseUrl}`));
