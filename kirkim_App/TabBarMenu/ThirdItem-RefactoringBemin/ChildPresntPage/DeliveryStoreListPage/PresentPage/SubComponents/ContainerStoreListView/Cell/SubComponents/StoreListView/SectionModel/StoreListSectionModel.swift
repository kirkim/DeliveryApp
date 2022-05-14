//
//  StoreListSectionModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import UIKit
import RxDataSources

struct SummaryStoreItem: Decodable {
    let storeCode: String
    let storeType: StoreType
    let storeName: String
    let averageRating: CGFloat
    let reviewCount: Int
    let minPrice: Int
    let deliveryPrice: Int
    let thumbnailUrl: String
    let twoMainMenuName: [String]
}

struct StoreListSection {
    var items: [Item]
}

extension StoreListSection: SectionModelType {
    typealias Item = SummaryStoreItem

    init(original: StoreListSection, items: [Item]) {
        self = original
        self.items = items
    }
}
