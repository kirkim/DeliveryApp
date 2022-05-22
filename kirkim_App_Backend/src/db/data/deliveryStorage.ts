import fs from 'fs';
import config from '../../config.js';
import { storeCodes } from './storeCodes.js';

/****** Menu ******/
export type Menu = {
  menuCode: string;
  menuName: string;
  description: string;
  menuPhotoUrl: string;
  price: number;
  menuDetail: MenuDetail;
};

export type MenuDetail = {
  description: string | undefined;
  optionSection: Array<OptionSection>;
};

export type OptionSection = {
  title: string;
  min: number | undefined;
  max: number | undefined;
  optionMenu: Array<OptionMenu>;
};

export type OptionMenu = {
  title: string;
  price: number | undefined;
};

/****** Section ******/
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
};

export type DetailStore = {
  code: string;
  storeName: string;
  deliveryPrice: number;
  minPrice: number;
  address: string;
  bannerPhotoUrl: string[];
  thumbnailUrl: string;
  menuSection: Array<MenuSection>;
};

export type StoreBundle = {
  storeCount: number;
  stores: Array<Store>;
  updatedAt: Date;
};

export let storeData: StoreBundle;

let mainUrl = config.static.url + '/delivery';
let hostUrl = config.server.baseUrl + '/delivery';

function updateData(storeCodes: string[]) {
  let storeBundle: Store[] = [];
  storeCodes.forEach((storeCode) => {
    let store: Store = {
      code: storeCode,
      storeType: randomStoreType(),
      storeName: randomStoreName(),
      deliveryPrice: randomDeliveryPrice(),
      minPrice: randomPrice(),
      address: randomAddressType(),
      bannerPhotoUrl: makeBannerImageUrlBundle(),
      thumbnailUrl: getThumbnailUrl(),
      menuSection: makeSection(),
    };
    storeBundle.push(store);
  });
  storeData = {
    storeCount: storeBundle.length,
    stores: storeBundle,
    updatedAt: new Date(),
  };
}

function getThumbnailUrl(): string {
  let thumbnail = '';
  let files = fs.readdirSync(mainUrl + '/thumbnail');
  let rand = Math.floor(Math.random() * files.length);
  thumbnail = files[rand] ?? '';
  return hostUrl + '/thumbnail/' + thumbnail;
}

function makeBannerImageUrlBundle(): string[] {
  let bannerUrlBundle: string[] = [];
  fs.readdir(mainUrl + '/banner', (_err, files) => {
    let rand = Math.floor(Math.random() * files.length);
    let bannerBundle = files[rand];
    fs.readdir(mainUrl + '/banner/' + bannerBundle, (_err, files) => {
      files.forEach((banner) => {
        let url = hostUrl + '/banner/' + bannerBundle + '/' + banner;
        bannerUrlBundle.push(url);
      });
    });
  });
  return bannerUrlBundle;
}

function makeSection(): MenuSection[] {
  let sectionBundle: MenuSection[] = [];
  let rand = Math.floor(Math.random() * 5 + 2);
  for (let i = 0; i < rand; i++) {
    let section: MenuSection = {
      title: randomSectionName(),
      menu: makeMenu(i.toString()),
    };
    sectionBundle.push(section);
  }
  return sectionBundle;
}

function makeMenu(sectionNumber: string): Menu[] {
  let menuBundle: Menu[] = [];
  fs.readdir(mainUrl + '/menu', (_err, files) => {
    let totalCount = files.length;
    const minCount = 2;
    let rand = Math.floor(Math.random() * (totalCount - minCount) + minCount);
    let numberArray = randomNumberArray(rand, totalCount);
    numberArray.forEach((index) => {
      let item: Menu = {
        menuCode: sectionNumber + '_' + index.toString(),
        menuName: randomMenuName(),
        description: randomMenuDescription(),
        menuPhotoUrl: hostUrl + '/menu/' + files[index],
        price: randomPrice(),
        menuDetail: makeMenuDetail(),
      };
      menuBundle.push(item);
    });
  });
  return menuBundle;
}

function makeMenuDetail(): MenuDetail {
  let sectionBundle: OptionSection[] = [];
  let maxCount = 5;
  let minCount = 2;
  let rand = Math.floor(Math.random() * (maxCount - minCount) + minCount);
  for (let i = 0; i < rand; i++) {
    let section: OptionSection = makeDetailSection();
    sectionBundle.push(section);
  }
  let menuDetail: MenuDetail = {
    description: randomDetailMenuDescription(),
    optionSection: sectionBundle,
  };
  return menuDetail;
}

function makeDetailSection(): OptionSection {
  let optionMenuBundle: OptionMenu[] = [];
  let maxCount = 5;
  let minCount = 2;
  let rand = Math.floor(Math.random() * (maxCount - minCount) + minCount);
  for (let i = 0; i < rand; i++) {
    let optionMenu: OptionMenu = makeOptionMenu();
    optionMenuBundle.push(optionMenu);
  }
  let section: OptionSection = {
    title: randomDetailSectionName(),
    min: randomNumber(0, 2),
    max: randomNumber(0, 3),
    optionMenu: optionMenuBundle,
  };
  return section;
}

function makeOptionMenu(): OptionMenu {
  let optionMenu: OptionMenu = {
    title: randomOptionName(),
    price: randomPriceOrUndefined(),
  };
  return optionMenu;
}

export function randomNumberArray(pickCount: number, totalCount: number): number[] {
  if (pickCount > totalCount) {
    console.log('why pickCount is bigger than totalCount!');
    return [];
  }
  let result: number[] = [];
  while (pickCount-- > 0) {
    result.push(pushNumber(result, totalCount));
  }
  return result;
}

function pushNumber(result: number[], totalCount: number): number {
  let rand = Math.floor(Math.random() * (totalCount - 1) + 1);
  if (!result.includes(rand)) {
    return rand;
  } else {
    return pushNumber(result, totalCount);
  }
}

function randomPrice(): number {
  let price: number[] = [3500, 7000, 8500, 4500, 2400, 10000, 15000, 23000];
  let rand = Math.floor(Math.random() * price.length);
  let rValue = price[rand];
  if (rValue == undefined) {
    rValue = 0;
  }
  return rValue;
}

function randomPriceOrUndefined(): number | undefined {
  let price: number[] = [3500, 7000, 8500, 4500, 2400, 10000, 15000, 23000];
  let rand = Math.floor(Math.random() * (price.length + 2));
  let rValue = price[rand];
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

function randomMenuName(): string {
  let menu: string[] = [
    '[신제품] 바스크 치즈 케이크 플레인',
    '계란말이',
    '마파두부',
    '국민반반피자',
    '서오릉 반반피자L',
    '미국식 닭고기 덮밥',
    '[셰프 추천]통목살 볶음밥',
    '칼국수손만두국(반공기밥포함)',
    '후라이드치킨',
    '떡튀순 세트',
    '석관동 로제떡볶이',
    '냉모밀(김치+단무지+무오로시+와사비)',
    '치즈돈가츠 정식(2P)',
    '의성마늘떡맵쌈',
    '2인 보쌈수육',
    '스파이시 크림파스타',
    '부채살 스테이크(구운야채를 곁들인)',
    '[NEW]봉골레파스타(면170g)',
    '꼰뻬찌오네 삐꼴라 (젤라또 4가지맛)',
    '춘천감자빵',
    '그릭요거망고놀라',
    '(HOT)아메리카노',
    '//달달쫀쫀// 말렌카 [카카오초코] 꿀 케이크',
    '크렘브륄레(톡깨서먹는 정통크림브륄레)',
    '초코커스터즈도넛',
    '에그마요 샌드위치',
    '마라샹궈',
    '새우살 청경채볶음',
    '똠양꿍쌀국수 1인분',
    '바삭킹8&너겟킹10+까망베르치즈소스',
    '에그 베이컨 해쉬브라운 부리또',
    '직화 돼지숙주덮밥',
    '참치마요덮밥',
    '엄청큰후라이드',
    '웰빙파닭',
    '순살3종세트',
    '간장 바베큐 치킨',
  ];
  let rand = Math.floor(Math.random() * menu.length);
  let rValue = menu[rand];
  if (rValue == undefined) {
    rValue = '마라샹궈';
  }
  return rValue;
}

export const enum StoreType {
  cafe = 'cafe',
  korean = 'korean',
  japanese = 'japanese',
  chinese = 'chinese',
  soup = 'soup',
  fastfood = 'fastfood',
  chicken = 'chicken',
  pizza = 'pizza',
  asian = 'asian',
  western = 'western',
  meat = 'meat',
  snackbar = 'snackbar',
}

function randomStoreType(): StoreType {
  let storeType: StoreType[] = [
    StoreType.cafe,
    StoreType.korean,
    StoreType.japanese,
    StoreType.chinese,
    StoreType.fastfood,
    StoreType.soup,
    StoreType.chicken,
    StoreType.pizza,
    StoreType.asian,
    StoreType.western,
    StoreType.meat,
    StoreType.snackbar,
  ];
  let rand = Math.floor(Math.random() * storeType.length);
  let rValue = storeType[rand];
  if (rValue == undefined) {
    rValue = StoreType.korean;
  }
  return rValue;
}

function randomMenuDescription(): string {
  let description: string[] = [
    '계란, 베이컨, 옥수수, 올리브, 병아리콩, 토마토 \n추천 드레싱:갈릭',
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

function randomDetailMenuDescription(): string | undefined {
  let description: string[] = [
    '계란, 베이컨, 옥수수, 올리브, 병아리콩, 토마토 \n추천 드레싱:갈릭',
    '1인매뉴에 적합',
    '허니크리스피강정(중), 볼케이노크리스피강정(중), 떡볶이, 아메리카노(2잔), 과일주스(1잔)',
    '[추천] Sugar50% / Ice고정',
    '아라비아따 리코타 치킨 버거 + 후렌치 후라이 (L) + 콜라 (L) 부드럽고 고소한 리코타 치즈와 매콤한 아라비아따 소스, 그리고 매콤 바삭한 상하이 치킨 패티가 조화를 이루는 치킨 버거.',
    '100% 알래스카 폴락 패티의 바삭함, 맥도날드의 타르타르소스와 부드러운 스팀번이 조화로운 필레 오 피쉬',
  ];
  let rand = Math.floor(Math.random() * (description.length + 3)); // 3개확률로 undefined배정
  let rValue = description[rand];

  return rValue;
}

function randomSectionName(): string {
  let description: string[] = [
    '추천메뉴',
    '20대가 선호하는 메뉴',
    '주문량이 많은 메뉴',
    '사이드 메뉴',
    '별미',
    '재주문이 높은 메뉴',
    '세트 메뉴',
    '당일 손질하여 만든 한정판 메뉴',
    '직화류',
    '고기만',
    '탕류',
    '메인메뉴',
    '튀김',
    '추가 메뉴',
  ];
  let rand = Math.floor(Math.random() * description.length);
  let rValue = description[rand];
  if (rValue == undefined) {
    rValue = '';
  }
  return rValue;
}

function randomStoreName(): string {
  let description: string[] = [
    '아름다운밤 연어육회 성신여대점',
    '스시 캘리포니아',
    '난바우동',
    '돈카와치&돈까스앤우동',
    '줄스시오',
    '기절초풍탕수육',
    '강화집밥',
    '뜸들이다성신여대점',
    '압구정 샌드위치',
    '국대떡볶이길음역점',
    '서울회관 성신여대점',
    '후라이드 참잘하는집(한성대점)',
    '폭풍토핑 피자스톰',
    '따띠 삼겹 성신여대점',
    '구구족 성신여대역점',
    '베트남쌀국수 몬스터포 성북점',
  ];
  let rand = Math.floor(Math.random() * description.length);
  let rValue = description[rand];
  if (rValue == undefined) {
    rValue = '';
  }
  return rValue;
}

function randomDetailSectionName(): string {
  let description: string[] = [
    '추가선택',
    '식사 선택1',
    '사이즈업',
    '서비스',
    '가격',
    '빨대 선택',
    '추가선택',
    '가격',
    '가격',
  ];
  let rand = Math.floor(Math.random() * description.length);
  let rValue = description[rand];
  if (rValue == undefined) {
    rValue = '';
  }
  return rValue;
}

function randomNumber(min: number, max: number): number | undefined {
  let undefinedRand = Math.random() * 10;
  if (undefinedRand < 5) {
    return undefined;
  }
  let rand = Math.floor(Math.random() * (max - min) + min);
  return rand;
}

function randomOptionName(): string {
  let description: string[] = [
    '소',
    '중',
    '대',
    '콜라',
    '사이다',
    '중국당면',
    '라면사리',
    '우동사리',
    '넙적당면',
    '1인분',
    '특',
    '곱빼기',
    '정식',
    '식전빵',
    '튀김',
    '돈까스토핑',
    '기본',
    '와사비추가',
  ];
  let rand = Math.floor(Math.random() * description.length);
  let rValue = description[rand];
  if (rValue == undefined) {
    rValue = '';
  }
  return rValue;
}

updateData(storeCodes);
