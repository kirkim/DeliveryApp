//
//  StoreType.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import Foundation

enum StoreType: String, CaseIterable, Decodable {
    case cafe = "cafe"
    case korean = "korean"
    case japanese = "japanese"
    case chinese = "chinese"
    case soup = "soup"
    case fastfood = "fastfood"
    case chicken = "chicken"
    case pizza = "pizza"
    case asian = "asian"
    case western = "western"
    case meat = "meat"
    case snackbar = "snackbar"
    
    var title:String {
        switch self {
        case .cafe:
            return "카페∙디저트"
        case .korean:
            return "한식"
        case .japanese:
            return "회∙일식"
        case .chinese:
            return "중식"
        case .soup:
            return "찜∙탕∙찌개"
        case .fastfood:
            return "패스트푸드"
        case .chicken:
            return "치킨"
        case .pizza:
            return "피자"
        case .asian:
            return "아시안"
        case .western:
            return "양식"
        case .meat:
            return "고기∙구이"
        case .snackbar:
            return "분식"
        }
    }
    
    var logoImage:String{
        switch self {
        case .cafe:
            return "cafe"
        case .korean:
            return "korean"
        case .japanese:
            return "japanese"
        case .chinese:
            return "chinese"
        case .soup:
            return "soup"
        case .fastfood:
            return "fastfood"
        case .chicken:
            return "chicken"
        case .pizza:
            return "pizza"
        case .asian:
            return "asian"
        case .western:
            return "western"
        case .meat:
            return "meat"
        case .snackbar:
            return "snackbar"
        }
    }
}
