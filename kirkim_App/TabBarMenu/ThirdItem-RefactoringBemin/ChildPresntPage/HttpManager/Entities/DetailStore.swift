//
//  DetailStore.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/15.
//

import Foundation

struct OptionMenu: Codable {
    let title: String
    var price: Int?
}

struct OptionSection: Codable {
    let title: String
    var min: Int?
    var max: Int?
    let optionMenu: [OptionMenu]
}

struct MenuDetail: Codable {
    var description: String?
    let optionSection: [OptionSection]
}

struct Menu: Codable {
    let menuCode: String
    let menuName: String
    let description: String
    let menuPhotoUrl: String
    let price: Int
    let menuDetail: MenuDetail
}

struct MenuSection: Codable {
    let title: String
    let menu: [Menu]
}

struct DetailStore: Codable {
    let code: String
    let storeName: String
    let deliveryPrice: Int
    let minPrice: Int
    let address: String
    let bannerPhotoUrl: [String]
    let thumbnailUrl: String
    let menuSection: [MenuSection]
}
