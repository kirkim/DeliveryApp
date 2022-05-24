//
//  ReviewItemModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/24.
//

import UIKit

protocol MagnetReviewItem {
    
}

struct ReviewItem: MagnetReviewItem, Codable {
    var storeInfo: StoreInfo
    var reviewId: Int
    var userInfo: UserInfo
    var rating: Int
    var description: String
    var photoUrl: String?
    var createAt: String
}

struct TotalRatingItem: MagnetReviewItem {
    var totalCount: Int
    var averageRating: CGFloat
}
