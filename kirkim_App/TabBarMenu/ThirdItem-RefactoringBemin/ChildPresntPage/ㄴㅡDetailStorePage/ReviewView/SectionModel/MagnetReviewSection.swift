//
//  MagnetReviewSection.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/25.
//

import UIKit
import RxDataSources

protocol MagnetReviewItem {
    
}

struct ReviewItem: MagnetReviewItem, Codable {
    var reviewId: Int
    var userId: String
    var rating: Int
    var description: String
    var photoUrl: String?
    var createAt: String
}

struct TotalRatingItem: MagnetReviewItem {
    var totalCount: Int
    var averageRating: CGFloat
}


enum MagnetReviewSectionModel {
    case totalRatingSection(items: [TotalRatingItem])
    case reviewSection(items: [ReviewItem])
}

extension MagnetReviewSectionModel: SectionModelType {
    typealias Item = MagnetReviewItem
    
    init(original: MagnetReviewSectionModel, items: [MagnetReviewItem]) {
        self = original
    }
    
    var items: [Item] {
        switch self {
        case .totalRatingSection(let items):
            return items
        case .reviewSection(let items):
            return items
        }
    }
}
