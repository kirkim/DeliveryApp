import express from 'express';
import * as deliveryController from '../controller/deliveryController.js';

const deliveryRouter = express.Router();

deliveryRouter.route('/summary').get(deliveryController.getSummaryStores);
deliveryRouter.route('/detail').get(deliveryController.getDetailStore);

export default deliveryRouter;
