import { Request, Response } from 'express';
import * as userDB from '../db/userData.js';
import bcrypt from 'bcrypt';

export async function postLogin(req: Request, res: Response) {
  const { userID, password } = req.body;
  const user: userDB.UserData | undefined = await userDB.findByUserID(userID);

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
  let newUser: userDB.User = {
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
  const userID = req.body.userID;
  const exist = await userDB.checkByUserID(userID);

  return res.status(200).json(exist);
}
