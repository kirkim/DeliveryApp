import { Request, Response } from 'express';
import { StoreType } from '../db/data/deliveryStorage.js';
import * as deliveryDB from '../db/deliveryData.js';
import * as reviewDB from '../db/reviewData.js';
import * as userDB from '../db/userData.js';

export async function getSummaryStores(req: Request, res: Response) {
  const { type } = req.query;
  if (type == undefined) {
    return res.sendStatus(400);
  }
  let datas = await deliveryDB.getSummaryStores(type as StoreType);
  return res.status(200).send(datas);
}

export async function getLikeSummaryStores(req: Request, res: Response) {
  const { id } = req.query;
  if (id == undefined) {
    return res.sendStatus(400);
  }
  let codes = await userDB.findLikeStoresById(id as string);
  if (codes == undefined) {
    return res.sendStatus(400);
  }
  let datas = await deliveryDB.getSummaryStoresByCode(codes);
  return res.status(200).send(datas);
}

export async function getDetailStore(req: Request, res: Response) {
  const { storeCode } = req.query;
  if (storeCode == undefined) {
    return res.sendStatus(400);
  }
  let datas = await deliveryDB.getDetailStore(storeCode as string);
  return res.status(200).send(datas);
}

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
