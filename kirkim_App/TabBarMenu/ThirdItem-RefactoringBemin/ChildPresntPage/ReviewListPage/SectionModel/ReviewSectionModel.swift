//
//  ReviewSectionModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
//

import UIKit
import RxDataSources

//struct StoreInfo {
//    var storeName: String
//    var code: String
//}

struct ReviewListCellItem: MagnetReviewItem {
    var reviewId: Int
    var storeInfo: StoreInfo
    var rating: Int
    var description: String
    var photoUrl: String?
    var createAt: String
}

struct ReviewSectionModel {
    var items: [ReviewListCellItem]
}

extension ReviewSectionModel: SectionModelType {
    typealias Item = ReviewListCellItem
    
    init(original: ReviewSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
