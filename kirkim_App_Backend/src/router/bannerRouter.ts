import express from 'express';
import * as bannerController from '../controller/bannerController.js';

const userRouter = express.Router();

userRouter.route('/').get(bannerController.getValidBanners);

export default userRouter;
