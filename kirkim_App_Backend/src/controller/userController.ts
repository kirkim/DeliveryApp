import { Request, Response } from 'express';
import * as userDB from '../db/userData.js';
import bcrypt from 'bcrypt';
import { User, UserData } from '../db/data/userStorage.js';

export async function postLogin(req: Request, res: Response) {
  const { userID, password } = req.body;
  const user: UserData | undefined = await userDB.findByUserID(userID);

  if (!user) {
    return res.sendStatus(400);
  }
  const ok = await bcrypt.compare(password, user.data.password);
  if (!ok) {
    return res.sendStatus(400);
  }
  return res.status(200).send(user);
}

export async function postSignUp(req: Request, res: Response) {
  const { userID, password, name } = req.body;
  const exist = await userDB.findByUserID(userID);
  if (exist) {
    return res.sendStatus(400);
  }
  let newUser: User = {
    userID: userID,
    password: password,
    name: name,
  };
  await userDB.create(newUser);
  return res.sendStatus(200);
}

export async function getAllUser(_req: Request, res: Response) {
  let datas = await userDB.getAllUser();
  return res.status(200).send(datas);
}

export async function checkId(req: Request, res: Response) {
  console.log(req.body);
  const userID = req.body.userID;
  const exist = await userDB.checkByUserID(userID);

  return res.status(200).json(exist);
}

export async function getLikeStoresById(req: Request, res: Response) {
  let { id } = req.query;
  if (id === undefined) {
    return res.sendStatus(400);
  }
  let datas = await userDB.findLikeStoresById(id as string);
  return res.status(200).json(datas);
}

export async function addOrRemoveLikeStore(req: Request, res: Response) {
  let { id, storeCode } = req.query;
  if (id === undefined || storeCode === undefined) {
    return res.sendStatus(400);
  }
  try {
    let data = await userDB.addOrRemoveLikeStore(id as string, storeCode as string);
    return res.status(200).json(data);
  } catch (error) {
    console.log(error);
    return res.sendStatus(400);
  }
}
