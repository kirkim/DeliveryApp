import fs from 'fs';
import config from '../../config.js';

export type Review = {
  reviewId: number;
  userId: number;
  rating: number;
  description: string;
  photoUrl: string[];
  createAt: Date;
};

export type ReviewBundle = {
  reviews: Array<Review>;
  averageRating: number;
};

export type Menu = {
  menuCode: number;
  menuName: string;
  description: string;
  menuPhotoUrl: string;
  price: number;
};

export type MenuSection = {
  title: string;
  menu: Array<Menu>;
};

export type Store = {
  code: string;
  storeType: StoreType;
  storeName: string;
  deliveryPrice: number;
  minPrice: number;
  address: string;
  bannerPhotoUrl: string[];
  thumbnailUrl: string;
  menuSection: Array<MenuSection>;
  review: ReviewBundle;
};

export type StoreBundle = {
  storeCount: number;
  stores: Array<Store>;
  updatedAt: Date;
};

export let data: StoreBundle;

function updateData() {
  let mainUrl = config.static.url + '/delivery';
  let storeBundle: Store[] = [];
  fs.readdir(mainUrl, (_err, files) => {
    files.forEach((storeName) => {
      let storeUrl = mainUrl + '/' + storeName;
      let store: Store = {
        code: storeName,
        storeType: randomStoreType(),
        storeName: storeName,
        deliveryPrice: randomDeliveryPrice(),
        minPrice: randomPrice(),
        address: randomAddressType(),
        bannerPhotoUrl: makeBannerImageUrlBundle(storeUrl),
        thumbnailUrl: getThumbnailUrl(storeUrl),
        menuSection: makeSection(storeUrl),
        review: makeReview(storeUrl),
      };
      storeBundle.push(store);
    });
  });
  data = {
    storeCount: storeBundle.length,
    stores: storeBundle,
    updatedAt: new Date(),
  };
}

function getThumbnailUrl(storeUrl: string): string {
  let thumbnail = '';
  let thumbnailUrl = storeUrl + '/thumbnail';
  fs.readdir(thumbnailUrl, (_err, files) => {
    files.forEach((thumbnailName) => {
      let url = thumbnailUrl + '/' + thumbnailName;
      thumbnail = url;
    });
  });
  return thumbnail;
}

function makeBannerImageUrlBundle(storeUrl: string): string[] {
  let bannerUrlBundle: string[] = [];
  let bannerUrl = storeUrl + '/banner';
  fs.readdir(bannerUrl, (_err, files) => {
    files.forEach((bannerName) => {
      let url = bannerUrl + '/' + bannerName;
      bannerUrlBundle.push(url);
    });
  });
  return bannerUrlBundle;
}

function makeSection(storeUrl: string): MenuSection[] {
  let sectionBundle: MenuSection[] = [];
  let sectionUrl = storeUrl + '/menu_section';
  fs.readdir(sectionUrl, (_err, files) => {
    files.forEach((sectionName) => {
      let section: MenuSection = {
        title: sectionName,
        menu: makeMenu(sectionUrl + '/' + sectionName),
      };
      sectionBundle.push(section);
    });
  });
  return sectionBundle;
}

function makeMenu(sectionUrl: string): Menu[] {
  let menuBundle: Menu[] = [];
  fs.readdir(sectionUrl, (_err, files) => {
    var index: number = 0;
    files.forEach((menuThumnail) => {
      let menuName = cutFileName(menuThumnail);
      let item: Menu = {
        menuCode: index,
        menuName: menuName,
        description: randomMenuDescription(),
        menuPhotoUrl: menuThumnail,
        price: randomPrice(),
      };
      menuBundle.push(item);
      index += 1;
    });
  });
  return menuBundle;
}

function makeReview(storeUrl: string): ReviewBundle {
  let reviewBundle: ReviewBundle;
  let reviews: Array<Review> = [];
  var index: number = 0;
  var sumRating: number = 0;
  let reviewUrl = storeUrl + '/review';
  fs.readdir(reviewUrl, (_err, files) => {
    files.forEach((reviewName) => {
      index += 1;
      let item: Review = {
        reviewId: index,
        userId: 1,
        rating: randomRating(),
        description: randomReviewDescription(),
        photoUrl: getReviewlUrl(reviewName),
        createAt: randomDate(),
      };
      sumRating += item.rating;
      reviews.push(item);
    });
  });
  reviewBundle = {
    reviews: reviews,
    averageRating: sumRating / index,
  };
  return reviewBundle;
}

function getReviewlUrl(reviewUrl: string): string[] {
  let reviewImageBundle: string[] = [];
  fs.readdir(reviewUrl, (_err, files) => {
    files.forEach((reviewImage) => {
      let url = reviewUrl + '/' + reviewImage;
      reviewImageBundle.push(url);
    });
  });
  return reviewImageBundle;
}

function randomPrice(): number {
  let price: number[] = [3500, 7000, 10000, 150000, 23000];
  let rand = Math.floor(Math.random() * price.length);
  let rValue = price[rand];
  if (rValue == undefined) {
    rValue = 0;
  }
  return rValue;
}

function randomRating(): number {
  let price: number[] = [1, 2, 3, 4, 5];
  let rand = Math.floor(Math.random() * price.length);
  let rValue = price[rand];
  if (rValue == undefined) {
    rValue = 5;
  }
  return rValue;
}

function randomDeliveryPrice(): number {
  let price: number[] = [0, 1000, 2000, 3000, 4000];
  let rand = Math.floor(Math.random() * price.length);
  let rValue = price[rand];
  if (rValue == undefined) {
    rValue = 0;
  }
  return rValue;
}

function randomDate(): Date {
  const maxDate = Date.now();
  const timestamp = Math.floor(Math.random() * maxDate);
  return new Date(timestamp);
}

function randomAddressType(): string {
  let address: string[] = [
    '서울 성북구 동소문동1가 32-3 맥도날드',
    '서울 성북구 동소문로25길 42 1층',
    '서울특별시 종로구 명륜길 44 1층',
    '서울 종로구 대명길 4 2층, 3층',
    '서울 성북구 동소문로22길 59 지하1층',
    '서울특별시 종로구 대명길 21-2 1층',
  ];
  let rand = Math.floor(Math.random() * address.length);
  let rValue = address[rand];
  if (rValue == undefined) {
    rValue = 'Cafe';
  }
  return rValue;
}

export const enum StoreType {
  'Cafe',
  'Korean',
  'Japanese',
  'Chinese',
  'Soup',
  'FastFood',
}

function randomStoreType(): StoreType {
  let storeType: StoreType[] = [
    StoreType.Cafe,
    StoreType.Korean,
    StoreType.Japanese,
    StoreType.Chinese,
    StoreType.FastFood,
    StoreType.Soup,
  ];
  let rand = Math.floor(Math.random() * storeType.length);
  let rValue = storeType[rand];
  if (rValue == undefined) {
    rValue = StoreType.Korean;
  }
  return rValue;
}

function randomMenuDescription(): string {
  let description: string[] = [
    '계란, 베이컨, 옥수수, 올리브, 병아리콩, 토마토 추천 드레싱:갈릭',
    '1인매뉴에 적합',
    '허니크리스피강정(중), 볼케이노크리스피강정(중), 떡볶이, 아메리카노(2잔), 과일주스(1잔)',
    '[추천] Sugar50% / Ice고정',
    '아라비아따 리코타 치킨 버거 + 후렌치 후라이 (L) + 콜라 (L) 부드럽고 고소한 리코타 치즈와 매콤한 아라비아따 소스, 그리고 매콤 바삭한 상하이 치킨 패티가 조화를 이루는 치킨 버거.',
    '100% 알래스카 폴락 패티의 바삭함, 맥도날드의 타르타르소스와 부드러운 스팀번이 조화로운 필레 오 피쉬',
  ];
  let rand = Math.floor(Math.random() * description.length);
  let rValue = description[rand];
  if (rValue == undefined) {
    rValue = '';
  }
  return rValue;
}

function randomReviewDescription(): string {
  let description: string[] = [
    '떡볶이 쫄깃하고 맵달하니 맛있어요! 순대는 하도 맛있다길래 얼마나 맛있나 했더니 아버지도 먹자마자 순대 맛있단 말씀부터 하시네요 ㅋㅋㅋ',
    '1인세트인데 닭강정 양도 푸짐하고 김밥에 참치도 아낌없이 넣어주시네요 👍🏻 단골될 것 같아요 잘 먹었습니다~',
    '잘먹었습니다!',
    '항상 맛있게 잘 먹구 있습니다~ 번창하세요!!',
    '항상 그랬듯너무 맛있습니다~~ 근데 종이용기가 안 와서 아쉬웠어요 ㅠㅠ',
    '로제 떡볶이도 완전 맛있는 소스였고~ 빙수는 양이 많아 좋습니다 맛있어요',
    '별점 난리났길래 걱정했는데 잘 왔음',
    '야채 진짜 꽉채워주시고 배송도 빨라요!!!! 대만족 앞으로도 섭웨이는 여기서 시켜먹을겁니당 ㅎㅎ',
  ];
  let rand = Math.floor(Math.random() * description.length);
  let rValue = description[rand];
  if (rValue == undefined) {
    rValue = '';
  }
  return rValue;
}

function cutFileName(files: string): string {
  let array = files.split('.', 2);
  let result = array[0] != undefined ? array[0] : '';
  return result;
}
updateData();
