//
//  SortSlideType.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/07.
//

import Foundation

enum SortSlideType: CaseIterable {
    case fastDeliveryTime
    case lowDeliveryPrice
    case basic
    case highOrder
    case highRating
    case nearest
    case muchlikes
    
    var title: String {
        switch self {
        case .fastDeliveryTime:
            return "배달 빠른 순"
        case .lowDeliveryPrice:
            return "배달팁 낮은 순"
        case .basic:
            return "기본순"
        case .highOrder:
            return "주문 많은 순"
        case .highRating:
            return "별점 높은 순"
        case .nearest:
            return "가까운 순"
        case .muchlikes:
            return "찜 많은 순"
        }
    }
}
