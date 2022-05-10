//
//  DeliveryMenuModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import Foundation
import UIKit

struct DeliveryMenuModel {
    var data: [DeliveryMenuSectionModel] = []
    let bannerCellData = DeliveryMenuSectionModel.SectionBanner(items: [
        BannerItem(data: BannerSources(bannerType: .basic,
                                       sources: [
                                        BannerSource(bannerImage: BeminCellImage.storedImage(name: "space_bread1"), presentVC: UIViewController()),
                                        BannerSource(bannerImage: BeminCellImage.storedImage(name: "space_bread2"), presentVC: UIViewController()),
                                        BannerSource(bannerImage: BeminCellImage.storedImage(name: "space_bread3"), presentVC: UIViewController())
                                       ]
                                      ))])
    let specialCellData = DeliveryMenuSectionModel.SectionSpecialMenu(items: [
        SpecialMenuItem(title: "딱\n1인분", backgroundImage: ""),
        SpecialMenuItem(title: "군침 싹!\n비빔밥", backgroundImage: ""),
        SpecialMenuItem(title: "딸기\n홈 뷔패", backgroundImage: ""),
        SpecialMenuItem(title: "떡볶이\n타임", backgroundImage: ""),
        SpecialMenuItem(title: "special Menu five", backgroundImage: "")
    ])
    
    let basicCellData: DeliveryMenuSectionModel
    
    init() {
        let basicItems = StoreType.allCases.map { type in
            return BasicMenuItem(logoImage: type.logoImage, menuType: type)
        }
        basicCellData = DeliveryMenuSectionModel.SectionBasicMenu(items: basicItems)
        
        [bannerCellData, specialCellData, basicCellData].forEach {
            self.data.append($0)
        }
    }
    
    func getBasicCellTitles() -> [String] {
        switch basicCellData {
        case .SectionBanner(_):
            return []
        case .SectionSpecialMenu(_):
            return []
        case .SectionBasicMenu(let items):
            return items.map { item in
                return item.menuType.title
            }
        }
    }
}
