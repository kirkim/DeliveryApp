export type TPost = {
  id: string;
  title: string;
  content: string;
  createdAt: Date;
  userId: string;
};

export type TPosts = TPost[];

export type TPostDetail = {
  post: TPost;
  username: string;
  name: string;
};
