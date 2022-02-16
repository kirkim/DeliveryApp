// import bcrypt from 'bcrypt';
// import config from '../config.js';

// password: 1231

export type User = {
  username: string;
  password: string;
  name: string;
  id: string;
};
export type Users = User[];

let users: Users = [
  {
    username: 'chichu',
    password: '$2b$12$onO6FjcLQx4ZHlpMgwzHg.2yAT9b6Jgde3ul6Jgr2CsUTza1JTqpm',
    name: 'Jisoo',
    id: '1',
  },
  {
    username: 'Bob123',
    password: '$2b$12$onO6FjcLQx4ZHlpMgwzHg.2yAT9b6Jgde3ul6Jgr2CsUTza1JTqpm',
    name: 'Bob',
    id: '2',
  },
];

// async function hashPassword(password) {
//   return await bcrypt.hash(password, config.bcrypt.saltRounds);
// }

// export async function create(user) {
//   user.password = await hashPassword(user.password);
//   const created = { ...user, id: Date.now().toString() };
//   users.push(created);
//   return created.id;
// }

// export async function updatePassword(id, password) {
//   const user = users.find((user) => user.id === id);
//   user.password = await hashPassword(password);
// }

// export async function updateProfile(id, data) {
//   const user = users.find((user) => user.id === id);
//   user.username = data.username;
//   user.name = data.name;
// }

// export async function findByUsername(username) {
//   return users.find((user) => user.username === username);
// }

export async function findById(id: string) {
  return users.find((user) => user.id === id);
}

// export async function getAllUsers() {
//   return users;
// }

// export async function findByIdAndDelete(id) {
//   const user = users.find((user) => user.id === id);
//   /* 유저 위임 */
//   user.name = 'none';
// }
