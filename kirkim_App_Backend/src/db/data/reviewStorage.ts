import fs from 'fs';
import config from '../../config.js';
import { getRandomUser, UserInfo } from '../userData.js';
import { randomNumberArray } from './deliveryStorage.js';
import { storeCodes } from './storeCodes.js';

/****** Review ******/
export type Review = {
  storeCode: string;
  reviewId: number;
  userInfo: UserInfo;
  rating: number;
  description: string;
  photoUrl: string | undefined;
  createAt: Date;
};

let mainUrl = config.static.url + '/delivery';
let hostUrl = config.server.baseUrl + '/delivery';

export let reviewData: Review[];

function updateReviewData(storeCodes: string[]) {
  let storeBundle: Review[] = [];
  storeCodes.forEach((storeCode) => {
    let temp = makeReviews(storeCode);
    storeBundle = storeBundle.concat(temp);
  });
  reviewData = storeBundle;
}

function makeReviews(storeCode: string): Review[] {
  let reviews: Review[] = [];
  let files = fs.readdirSync(mainUrl + '/review'); // 리뷰모델은 요소들의 평점 평균값을 실시간으로 계산해야하므로 동기적으로 처리함
  let totalCount = files.length;
  let minCount = 4;
  let rand = Math.floor(Math.random() * (totalCount - minCount) + minCount);
  let numberArray = randomNumberArray(rand, totalCount);
  numberArray.forEach((index) => {
    let item: Review = {
      storeCode: storeCode,
      reviewId: index,
      userInfo: getRandomUser(),
      rating: randomRating(),
      description: randomReviewDescription(),
      photoUrl: sometimesGiveUndefined(files[index]!),
      createAt: randomDate(),
    };
    reviews.push(item);
  });
  // Typesecript에서 Date타입 연산하기위해서는 '+'기호를 붙여서 명시적으로 연산이 가능한 숫자로 표시해야됨
  reviews.sort((a, b) => +b.createAt - +a.createAt);
  return reviews;
}

function sometimesGiveUndefined(fileName: string): string | undefined {
  let rand = Math.floor(Math.random() * 10);
  if (rand > 3) {
    return hostUrl + /review/ + fileName;
  } else {
    return undefined;
  }
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

function randomDate(): Date {
  const today = new Date();
  const rand = Math.floor(Math.random() * 60);
  const resultDate = new Date(today.setDate(today.getDate() - rand));
  return resultDate;
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
    '음식 너무 맛있는데\n배달 너무 늦었어요.o.o\n음료수라도 주실줄 알았는데..ㅡㅡ',
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

updateReviewData(storeCodes);
