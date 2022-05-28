//
//  DeliveryHttpType.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/27.
//

import Foundation

enum DeliveryGetType: UrlType {
    case summaryStores(type: StoreType)
    case likeSummaryStores(userCode: String)
    case detailStore(storeCode: String)
    case allReviews(storeCode: String)
    case summaryReviews(storeCode: String, count: Int)
    case reviewById(id: String)
    
    var url: String {
        let BASE_URL: String = "http://localhost:8080"
        switch self {
        case .summaryStores(let type):
            return "\(BASE_URL)/delivery/summary?type=\(type.rawValue)"
        case .likeSummaryStores(let id):
            return "\(BASE_URL)/delivery/likeSummary?id=\(id)"
        case .detailStore(let code):
            return "\(BASE_URL)/delivery/detail?storeCode=\(code)"
        case .allReviews(let code):
            return "\(BASE_URL)/delivery/reviews?storeCode=\(code)"
        case .summaryReviews(let code, let count):
            return "\(BASE_URL)/delivery/reviews?storeCode=\(code)&count=\(count)"
        case .reviewById(let id):
            return "\(BASE_URL)/delivery/reviews?id=\(id)"
        }
    }
}
