import { storeData, StoreType, DetailStore, Store } from './data/deliveryStorage.js';
import { StoreInfo } from './data/reviewStorage.js';
import { getReviewDataForSummary } from './reviewData.js';

export type SummaryStore = {
  storeCode: string;
  storeType: StoreType;
  storeName: string;
  averageRating: number;
  reviewCount: number;
  minPrice: number;
  deliveryPrice: number;
  thumbnailUrl: string;
  twoMainMenuName: [string, string];
};

export function getStoreInfo(storeCode: string): StoreInfo {
  var name: string = '';
  storeData.stores.forEach((store) => {
    if (store.code === storeCode) {
      name = store.storeName;
      return;
    }
  });
  return {
    storeCode: storeCode,
    storeName: name,
  };
}

export async function getSummaryStoresByCode(codes: string[]): Promise<Array<SummaryStore>> {
  let validStores: Store[] = [];
  codes.forEach((code) => {
    let tempStore = storeData.stores.find((store) => store.code === code);
    if (tempStore !== undefined) {
      validStores.push(tempStore);
    }
  });

  let summaryStores: Array<SummaryStore> = validStores.map((store) => {
    let reviewData = getReviewDataForSummary(store.code);
    let summaryStore: SummaryStore = {
      storeCode: store.code,
      storeType: store.storeType,
      storeName: store.storeName,
      averageRating: reviewData.average,
      reviewCount: reviewData.count,
      minPrice: store.minPrice,
      deliveryPrice: store.deliveryPrice,
      thumbnailUrl: store.thumbnailUrl,
      twoMainMenuName: [
        store.menuSection[0]?.menu[0]?.menuName!,
        store.menuSection[0]?.menu[1]?.menuName!,
      ],
    };
    return summaryStore;
  });
  return summaryStores;
}

export async function getSummaryStores(type: StoreType): Promise<Array<SummaryStore>> {
  let validStores = storeData.stores.filter((store) => {
    return store.storeType == type;
  });

  let summaryStores: Array<SummaryStore> = validStores.map((store) => {
    let reviewData = getReviewDataForSummary(store.code);
    let summaryStore: SummaryStore = {
      storeCode: store.code,
      storeType: store.storeType,
      storeName: store.storeName,
      averageRating: reviewData.average,
      reviewCount: reviewData.count,
      minPrice: store.minPrice,
      deliveryPrice: store.deliveryPrice,
      thumbnailUrl: store.thumbnailUrl,
      twoMainMenuName: [
        store.menuSection[0]?.menu[0]?.menuName!,
        store.menuSection[0]?.menu[1]?.menuName!,
      ],
    };
    return summaryStore;
  });
  return summaryStores;
}

export async function getDetailStore(storeCode: string): Promise<DetailStore | undefined> {
  let store = storeData.stores.find((store) => store.code === storeCode);
  if (store == undefined) {
    return undefined;
  }
  let detailStore: DetailStore = {
    code: store.code,
    storeName: store.storeName,
    deliveryPrice: store.deliveryPrice,
    minPrice: store.minPrice,
    address: store.address,
    bannerPhotoUrl: store.bannerPhotoUrl,
    thumbnailUrl: store.thumbnailUrl,
    menuSection: store.menuSection,
  };
  return detailStore;
}
