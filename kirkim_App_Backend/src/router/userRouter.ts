import express from 'express';
import * as userController from '../controller/userController.js';

const userRouter = express.Router();

userRouter.route('/login').post(userController.postLogin);

export default userRouter;
