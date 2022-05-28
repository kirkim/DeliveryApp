export type UserInfo = {
  userID: string;
  name: string;
  id: string;
};

export type User = {
  userID: string;
  password: string;
  name: string;
};

export type UserData = {
  id: string;
  data: User;
  likeStores: string[];
};

export type UserDatas = UserData[];

export let userDatas: UserDatas = [
  {
    id: '1',
    data: {
      userID: 'chichu',
      password: '$2b$12$onO6FjcLQx4ZHlpMgwzHg.2yAT9b6Jgde3ul6Jgr2CsUTza1JTqpm',
      name: 'Jisoo',
    },
    likeStores: ['1', '2', '3'],
  },
  {
    id: '2',
    data: {
      userID: 'Bob123',
      password: '$2b$12$onO6FjcLQx4ZHlpMgwzHg.2yAT9b6Jgde3ul6Jgr2CsUTza1JTqpm',
      name: 'Bob',
    },
    likeStores: ['4', '5', '6'],
  },
];
