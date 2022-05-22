import express from 'express';
import * as reviewController from '../controller/reviewController.js';

const reviewRouter = express.Router();

reviewRouter.route('/all').get(reviewController.getAllReviews);
reviewRouter.route('/some').get(reviewController.getReviews);

export default reviewRouter;
