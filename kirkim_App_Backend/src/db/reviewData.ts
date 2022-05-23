import { Review, reviewData } from './data/reviewStorage.js';

export type ReviewJson = {
  reviews: Review[];
  averageRating: number;
};

export type ReviewDataForSummary = {
  average: number;
  count: number;
};

export function getReviewDataForSummary(storeCode: string): ReviewDataForSummary {
  let totalCount: number = 0;
  let sumRating: number = 0;
  reviewData.forEach((review) => {
    if (review.storeInfo.storeCode === storeCode) {
      totalCount += 1;
      sumRating += review.rating;
      return true;
    }
    return false;
  });
  if (totalCount === 0) {
    return {
      average: 0,
      count: 0,
    };
  }
  let result: ReviewDataForSummary = {
    average: sumRating / totalCount,
    count: totalCount,
  };
  return result;
}

export async function getAllReviews(storeCode: string): Promise<ReviewJson | undefined> {
  let totalCount: number = 0;
  let sumRating: number = 0;
  let reviews = reviewData.filter((review) => {
    if (review.storeInfo.storeCode === storeCode) {
      totalCount += 1;
      sumRating += review.rating;
      return true;
    }
    return false;
  });
  if (reviews == undefined) {
    return undefined;
  }
  let reviewJson: ReviewJson = {
    reviews: reviews,
    averageRating: sumRating / totalCount,
  };
  return reviewJson;
}

export async function getReviews(storeCode: string, count: number): Promise<Review[] | undefined> {
  let reviews: Review[] = [];
  let flag: number = 0;
  for (let i = 0; i < reviewData.length; i++) {
    let review = reviewData[i]!;
    if (review.storeInfo.storeCode === storeCode && review.photoUrl !== undefined) {
      flag++;
      reviews.push(review);
    }
    if (flag === count) {
      break;
    }
  }
  if (reviews == undefined) {
    return undefined;
  }
  return reviews;
}

export async function getReviewsById(id: String): Promise<Review[] | undefined> {
  let reviews: Review[] = [];
  reviewData.forEach((review) => {
    if (review.userInfo.id == id) {
      reviews.push(review);
    }
  });
  return reviews;
}
