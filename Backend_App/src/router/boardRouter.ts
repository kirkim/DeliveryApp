import express from 'express';
import * as boardCtl from '../controller/boardController.js';

const boardRouter = express.Router();

boardRouter.route('/').get(boardCtl.getBoards);
boardRouter.route('/view').get(boardCtl.getPost);

export default boardRouter;
