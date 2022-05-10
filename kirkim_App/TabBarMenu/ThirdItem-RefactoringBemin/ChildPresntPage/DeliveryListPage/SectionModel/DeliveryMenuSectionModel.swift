//
//  DeliveryMenuSectionModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import RxDataSources

///After Refactoring
enum DeliveryMenuSectionModel {
    case SectionBanner(items: [BannerItem])
    case SectionSpecialMenu(items: [SpecialMenuItem])
    case SectionBasicMenu(items: [BasicMenuItem])
}

protocol DeliveryMenuSectionItem {
    
}

struct BannerItem: DeliveryMenuSectionItem {
    var data: BannerSources
}


struct SpecialMenuItem: DeliveryMenuSectionItem {
    var title: String
    var backgroundImage: String
}

struct BasicMenuItem: DeliveryMenuSectionItem {
    var logoImage: String
    var menuType: StoreType
}

extension DeliveryMenuSectionModel: SectionModelType {
    typealias Item = DeliveryMenuSectionItem
    
    init(original: DeliveryMenuSectionModel, items: [DeliveryMenuSectionItem]) {
        self = original
    }
    
    var headers: String? {
        switch self {
        default:
            return nil
        }
    }
    
    var items: [Item] {
        switch self {
        case .SectionBanner(let items):
            return items
        case .SectionSpecialMenu(let items):
            return items
        case .SectionBasicMenu(let items):
            return items
        }
    }
}
