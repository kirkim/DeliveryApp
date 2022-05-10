//
//  PickSortTypeViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/05.
//

import Foundation
import RxSwift
import RxCocoa

enum ReViewSortType {
    case latestOrder
    case highStarRating
    case lowStarRating
    var title:String {
        switch self {
        case .latestOrder:
            return "최신순"
        case .highStarRating:
            return "별점 높은순"
        case .lowStarRating:
            return "별점 낮은순"
        }
    }
}

struct PickSortTypeViewModel {
    let selectedSortType = BehaviorRelay<ReViewSortType>(value: .latestOrder)
    
    init() {
        
    }
}
