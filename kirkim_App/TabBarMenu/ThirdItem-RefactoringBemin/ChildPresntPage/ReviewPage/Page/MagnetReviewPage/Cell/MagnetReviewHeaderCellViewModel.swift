//
//  MagnetReviewHeaderCellViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/28.
//

import RxCocoa
import Foundation

struct MagnetReviewHeaderCellViewModel {
    
    // View(MagnetReviewHeaderCell) -> ViewModel -> ParentViewModel
    let hasPhoto = BehaviorRelay<Bool>(value: true)
    let sortButtonTapped = PublishRelay<Void>()
    
    // ParentViewModel -> ViewModel -> View
    let selectedSortType = BehaviorRelay<ReViewSortType>(value: .latestOrder)
    
    init() {
        
    }
}

