import express from 'express';
import * as bannerController from '../controller/bannerController.js';

const bannerRouter = express.Router();

bannerRouter.route('/').get(bannerController.getValidBanners);

export default bannerRouter;
