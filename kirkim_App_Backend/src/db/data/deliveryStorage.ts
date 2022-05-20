import fs from 'fs';
import config from '../../config.js';

/****** Review ******/
export type Review = {
  reviewId: number;
  userId: string;
  rating: number;
  description: string;
  photoUrl: string | undefined;
  createAt: Date;
};

export type ReviewBundle = {
  reviews: Array<Review>;
  averageRating: number;
};

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
  review: ReviewBundle;
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

export let data: StoreBundle;

let mainUrl = config.static.url + '/delivery';
let hostUrl = config.server.baseUrl + '/delivery';

function updateData(storeCount: number) {
  let storeBundle: Store[] = [];
  for (let i = 0; i < storeCount; i++) {
    let store: Store = {
      code: i.toString(),
      storeType: randomStoreType(),
      storeName: randomStoreName(),
      deliveryPrice: randomDeliveryPrice(),
      minPrice: randomPrice(),
      address: randomAddressType(),
      bannerPhotoUrl: makeBannerImageUrlBundle(),
      thumbnailUrl: getThumbnailUrl(),
      menuSection: makeSection(),
      review: makeReview(),
    };
    storeBundle.push(store);
  }
  data = {
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

function makeReview(): ReviewBundle {
  let reviewBundle: ReviewBundle;
  let reviews: Review[] = [];
  let reviewCount: number = 0;
  let sumRating: number = 0;

  let files = fs.readdirSync(mainUrl + '/review'); // 리뷰모델은 요소들의 평점 평균값을 실시간으로 계산해야하므로 동기적으로 처리함
  let totalCount = files.length;
  let minCount = 4;
  let rand = Math.floor(Math.random() * (totalCount - minCount) + minCount);
  let numberArray = randomNumberArray(rand, totalCount);
  numberArray.forEach((index) => {
    let item: Review = {
      reviewId: index,
      userId: '1', // [TODO] 랜덤유저아이디 만들어주자
      rating: randomRating(),
      description: randomReviewDescription(),
      photoUrl: sometimesGiveUndefined(files[index]!),
      createAt: randomDate(),
    };
    sumRating += item.rating;
    reviewCount++;
    reviews.push(item);
  });
  // Typesecript에서 Date타입 연산하기위해서는 '+'기호를 붙여서 명시적으로 연산이 가능한 숫자로 표시해야됨
  reviews.sort((a, b) => +b.createAt - +a.createAt);

  reviewBundle = {
    reviews: reviews,
    averageRating: reviewCount == 0 ? 0.0 : sumRating / reviewCount,
  };
  return reviewBundle;
}

function sometimesGiveUndefined(fileName: string): string | undefined {
  let rand = Math.floor(Math.random() * 10);
  if (rand > 3) {
    return hostUrl + /review/ + fileName;
  } else {
    return undefined;
  }
}

function randomNumberArray(pickCount: number, totalCount: number): number[] {
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
  const today = new Date();
  const rand = Math.floor(Math.random() * 60);
  const resultDate = new Date(today.setDate(today.getDate() - rand));
  return resultDate;
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
    '항상 가서만 먹었는데 너무 빨리 가져다주시고 감사합니다 너무 맛있게 잘 먹었습니다👍🏻 👍🏻 👍🏻',
    '음식 너무 맛있는데/n배달 너무 늦었어요.o.o/n음료수라도 주실줄 알았는데..ㅡㅡ',
    '찹쌀페이스트리는 언제 먹어도 맛있네요',
    '너무 늦은 시간에 주문했는데 수락해주시고 정성껏 만들어 보내주셔서 감사합니다!',
    '달달하고 너무 맛있어용',
    '도우가 너무 특별했습니다 말랑말랑 부드럽고 피자를 먹으면 소화가 잘 안되는데 속이 너무 편하고 소화가 잘 됐습니다 그래서 우리아이가 피자를 싫어하는데 이건 너무 맛있다고 합니다 맛도 있고 양도 푸짐하고 피자는 여기로 정착해야 겠어요~~^^',
    '역시는역시!!굿굿',
    '',
    '두 번째로 시켰는데 역시 맛있었습니다 양도 푸짐하고 ㅎㅎ 혼밥러 최고 배달집입니다',
    '어떤분이 리뷰에서 추천한 새우볼 진짜 맛있어요! 맵찔이인 저에게 보통맛도 맵지만 ㅠ 맛있게 먹었습니다.. 맵찔이도 매운거 먹고 싶은 날이 있잖아요..\n맛있게 매워요!',
  ];
  let rand = Math.floor(Math.random() * description.length);
  let rValue = description[rand];
  if (rValue == undefined) {
    rValue = '';
  }
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

updateData(200);
