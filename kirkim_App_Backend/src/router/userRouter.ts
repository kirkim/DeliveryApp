import express from 'express';
import * as userController from '../controller/userController.js';

const userRouter = express.Router();

userRouter.route('/login').post(userController.postLogin);
userRouter.route('/signup').post(userController.postSignUp);
userRouter.route('/').get(userController.getAllUser);

export default userRouter;
