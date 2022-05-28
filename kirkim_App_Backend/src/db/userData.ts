import bcrypt from 'bcrypt';
import config from '../config.js';
import { User, UserData, UserDatas, userDatas, UserInfo } from './data/userStorage.js';

export function getRandomUser(): UserInfo {
  let rand = Math.floor(Math.random() * userDatas.length);
  let rValue = userDatas[rand]!;
  return {
    userID: rValue.data.userID,
    name: rValue.data.name,
    id: rValue.id,
  };
}

async function hashPassword(password: string): Promise<string> {
  return await bcrypt.hash(password, config.bcrypt.saltRounds);
}

export async function create(user: User) {
  user.password = await hashPassword(user.password);
  const created = { data: user, id: Date.now().toString(), likeStores: [] };
  userDatas.push(created);
  return;
}

export async function findByUserID(userID: string): Promise<UserData | undefined> {
  return userDatas.find((user) => user.data.userID === userID);
}

export async function findByID(id: string): Promise<UserData | undefined> {
  return userDatas.find((user) => user.id === id);
}

export async function checkByUserID(userID: string): Promise<Boolean> {
  let checkValue = userDatas.find((user) => user.data.userID === userID);
  if (checkValue === undefined) {
    return true;
  }
  return false;
}

export async function getAllUser(): Promise<UserDatas> {
  return userDatas;
}

export async function findLikeStoresById(id: string): Promise<string[] | undefined> {
  let data = userDatas.find((data) => data.id === id);
  return data?.likeStores;
}

export async function addOrRemoveLikeStore(id: string, storeCode: string): Promise<boolean> {
  let user = userDatas.find((user) => user.id === id);
  if (user === undefined) {
    throw new Error('No User');
  }
  let isDelete: boolean = false;
  let hasStore = user?.likeStores.filter((code) => {
    if (code == storeCode) {
      isDelete = true;
      return false;
    }
    return true;
  });
  if (isDelete == false) {
    hasStore?.unshift(storeCode);
  }
  user.likeStores = hasStore;
  return !isDelete;
}
