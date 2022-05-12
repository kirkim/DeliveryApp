//
//  ShoppingCartSectionModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import RxDataSources

enum ShoppingCartType: Codable {
    case delivery
    case takeout
}

protocol ShoppingCartItem: Codable {
    
}

struct CartMenuItem: ShoppingCartItem {
    var title: String
    var thumbnailUrl: String
    var menuString: [String]
    var price: Int
    var count: Int
}

struct CartTypeItem: ShoppingCartItem {
    var type: ShoppingCartType
}

struct CartPriceItem: ShoppingCartItem {
    var deliveryTip: Int
    var menuPrice: Int
}

enum ShoppingCartSectionModel {
    case cartMenuSection(items: [CartMenuItem])
    case cartTypeSection(items: [CartTypeItem])
    case cartPriceSection(items: [CartPriceItem])
}

extension ShoppingCartSectionModel: SectionModelType {
    typealias Item = ShoppingCartItem
    
    init(original: ShoppingCartSectionModel, items: [ShoppingCartItem]) {
        self = original
    }
    
    var items: [Item] {
        switch self {
        case .cartMenuSection(let items):
            return items
        case .cartTypeSection(let items):
            return items
        case .cartPriceSection(let items):
            return items

        }
    }
}
