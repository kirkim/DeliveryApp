//
//  RxBannerCollectionViewModel.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa

struct BeminBannerListViewModel {
    let cellImageName: Driver<[BeminCellImage]>
    let nowPage = BehaviorSubject<Int>(value: 0)
    
    // View -> ViewModel
    let cellClicked = PublishRelay<IndexPath>()
    
    // ViewModel -> parentView
    let presentVC: Signal<IndexPath>
    
    init(bannerImage: [BeminCellImage]) {
        self.cellImageName = BehaviorSubject<[BeminCellImage]>(value: bannerImage)
        .asDriver(onErrorJustReturn: [])
        
        presentVC = cellClicked
            .asSignal(onErrorJustReturn: IndexPath(row: 0, section: 0))
    }
}
