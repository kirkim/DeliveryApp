import { Request, Response } from 'express';
import * as bannerDB from '../db/bannerData.js';

export async function getValidBanners(_req: Request, res: Response) {
  let datas = await bannerDB.getAllBanner();
  return res.status(200).send(datas);
}
