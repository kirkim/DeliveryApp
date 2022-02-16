import * as postDb from '../db/postData.js';
import * as userDb from '../db/userData.js';
import { Request, Response } from 'express';

type PostDetail = {
  post: postDb.Post;
  username: string;
  name: string;
};

export async function getBoards(req: Request, res: Response) {
  const range: number = req.query.range ? Number(req.query.range) : 10;
  const page: number = req.query.page ? Number(req.query.page) : 1;
  const posts = await postDb.getPosts((page - 1) * range, range);
  return res.status(200).json(posts);
}

export async function getPost(req: Request, res: Response) {
  const postId = String(req.query.no);
  const post: postDb.Post | undefined = await postDb.findById(postId);
  if (post == null) {
    return res.sendStatus(404);
    //throw new Error(`Can't find Post!`);
  }
  const user: userDb.User | undefined = await userDb.findById(post.userId);
  if (user == null) {
    return res.sendStatus(404);
    //throw new Error(`Can't find Post or User!`);
  }
  const data: PostDetail = {
    post,
    username: user.username,
    name: user.name,
  };
  return res.status(200).json(data);
}
