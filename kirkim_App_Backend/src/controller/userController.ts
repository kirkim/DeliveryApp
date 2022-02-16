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
