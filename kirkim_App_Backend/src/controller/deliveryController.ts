import { Request, Response } from 'express';
import { StoreType } from '../db/data/deliveryStorage.js';
import * as deliveryDB from '../db/deliveryData.js';

export async function getSummaryStores(req: Request, res: Response) {
  const { type } = req.query;
  if (type == undefined) {
    return res.sendStatus(400);
  }
  let datas = await deliveryDB.getSummaryStores(type as StoreType);
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

export async function getAllReviews(req: Request, res: Response) {
  const { storeCode } = req.query;
  if (storeCode == undefined) {
    return res.sendStatus(400);
  }
  let datas = await deliveryDB.getAllReviews(storeCode as string);
  return res.status(200).send(datas);
}

export async function getReviews(req: Request, res: Response) {
  const { storeCode, count } = req.query;
  if (storeCode == undefined || count == undefined) {
    return res.sendStatus(400);
  }
  let datas = await deliveryDB.getReviews(storeCode as string, Number(count));
  return res.status(200).send(datas);
}
