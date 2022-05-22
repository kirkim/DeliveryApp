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
    if (review.storeCode === storeCode) {
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
    if (review.storeCode === storeCode) {
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
  let i = 0;
  reviewData.filter((review) => {
    if (review.storeCode === storeCode) {
      i++;
      reviews.push(review);
    }
    if (i == count) {
      return;
    }
  });
  if (reviews == undefined) {
    return undefined;
  }

  return reviews;
}
