//
//  ShoppingCartSectionModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import RxDataSources

enum ShoppingCartType {
    case delivery
    case takeout
}

protocol ShoppingCartItem {
    
}

struct cartMenuItem: ShoppingCartItem {
    var reviewId: Int
    var userId: String
    var rating: Int
    var description: String
    var photoUrl: String?
    var createAt: String
}

struct cartTypeItem: ShoppingCartItem {
    var type: ShoppingCartType
}

struct cartPriceItem: ShoppingCartItem {
    var totalPrice: Int
    var deliveryPrice: Int
}

enum ShoppingCartSectionModel {
    case cartMenuSection(items: [cartMenuItem])
    case cartTypeSection(items: [cartTypeItem])
    case cartPriceSection(items: [cartPriceItem])
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
