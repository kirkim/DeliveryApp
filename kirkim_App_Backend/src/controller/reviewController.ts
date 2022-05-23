import { Request, Response } from 'express';
import * as reviewDB from '../db/reviewData.js';

export async function getReviews(req: Request, res: Response) {
  const { storeCode, count, id } = req.query;
  if (id !== undefined) {
    let datas = await reviewDB.getReviewsById(id as string);
    return res.status(200).send(datas);
  } else if (storeCode === undefined) {
    return res.sendStatus(400);
  }
  if (count === undefined) {
    let datas = await reviewDB.getAllReviews(storeCode as string);
    return res.status(200).send(datas);
  } else {
    let datas = await reviewDB.getReviews(storeCode as string, Number(count));
    return res.status(200).send(datas);
  }
}
