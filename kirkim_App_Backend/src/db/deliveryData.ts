import { data, StoreType, DetailStore, ReviewBundle, Review } from './data/deliveryStorage.js';

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

export async function getSummaryStores(type: StoreType): Promise<Array<SummaryStore>> {
  let validStores = data.stores.filter((store) => {
    return store.storeType == type;
  });

  let summaryStores: Array<SummaryStore> = validStores.map((store) => {
    let summaryStore: SummaryStore = {
      storeCode: store.code,
      storeType: store.storeType,
      storeName: store.storeName,
      averageRating: store.review.averageRating,
      reviewCount: store.review.reviews.length,
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
  let store = data.stores.find((store) => store.code === storeCode);
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

export async function getAllReviews(storeCode: string): Promise<ReviewBundle | undefined> {
  let store = data.stores.find((store) => store.code === storeCode);
  if (store == undefined) {
    return undefined;
  }
  return store.review;
}

export async function getReviews(storeCode: string, count: number): Promise<Review[] | undefined> {
  let store = data.stores.find((store) => store.code === storeCode);
  if (store == undefined) {
    return undefined;
  }
  let reviewBundle = store.review.reviews.filter((review) => {
    return review.photoUrl !== undefined;
  });
  let reviews: Review[] = [];
  count = count > reviewBundle.length ? reviewBundle.length : count;
  for (let i = 0; i < count; i++) {
    let review = reviewBundle[i];
    if (review !== undefined) {
      reviews.push(review);
    }
  }
  return reviews;
}
