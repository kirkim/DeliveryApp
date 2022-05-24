//
//  ReviewSectionModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
//

import UIKit
import RxDataSources

struct ReviewSectionModel {
    var items: [ReviewItem]
}

extension ReviewSectionModel: SectionModelType {
    typealias Item = ReviewItem
    
    init(original: ReviewSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
