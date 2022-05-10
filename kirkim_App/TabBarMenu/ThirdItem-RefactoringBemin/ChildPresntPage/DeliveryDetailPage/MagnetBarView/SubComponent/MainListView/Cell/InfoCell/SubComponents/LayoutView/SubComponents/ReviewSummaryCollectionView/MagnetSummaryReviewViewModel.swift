//
//  MagnetInfoCollectionViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import UIKit
import RxCocoa
import RxSwift

enum MagnetInfoCellType {
    case review(row: Int)
}

struct MagnetSummaryReviewViewModel {
    // View -> ViewModel
    let itemSelected = PublishRelay<Int?>()
    
    // ViewMoel -> ParentViewModel
    let popVC: Signal<Int?>
    
    init() {
        popVC = itemSelected
            .asSignal(onErrorJustReturn: nil)
    }
}


