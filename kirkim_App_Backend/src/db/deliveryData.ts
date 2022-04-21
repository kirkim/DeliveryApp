import { data, StoreType } from './data/deliveryStorage.js';

export type SummaryStore = {
  code: string;
  storeName: string;
  averageRating: number;
  minPrice: number;
  deliveryPrice: number;
  thumbnailUrl: string;
  twoMainMenuName: [string, string];
};

export async function getSummaryStores(type: StoreType) {
  let validStores = data.stores.filter((store) => {
    return store.storeType == type;
  });

  let summaryStores: Array<SummaryStore> = validStores.map((store) => {
    let summaryStore: SummaryStore = {
      code: store.code,
      storeName: store.storeName,
      averageRating: store.review.averageRating,
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
