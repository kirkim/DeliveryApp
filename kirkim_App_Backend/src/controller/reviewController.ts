import { Request, Response } from 'express';
import * as reviewDB from '../db/reviewData.js';

export async function getAllReviews(req: Request, res: Response) {
  const { storeCode } = req.query;
  if (storeCode == undefined) {
    return res.sendStatus(400);
  }
  let datas = await reviewDB.getAllReviews(storeCode as string);
  return res.status(200).send(datas);
}

export async function getReviews(req: Request, res: Response) {
  const { storeCode, count } = req.query;
  if (storeCode == undefined || count == undefined) {
    return res.sendStatus(400);
  }
  let datas = await reviewDB.getReviews(storeCode as string, Number(count));
  return res.status(200).send(datas);
}
