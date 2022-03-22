//
//  RxBannerCollectionViewModel.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa

struct RxBannerListViewModel {
    let cellImageName: Driver<[String]>
    let nowPage = BehaviorSubject<Int>(value: 0)
    
    init(imageNames: [String]) {
        self.cellImageName = BehaviorSubject<[String]>(value: imageNames)
        .asDriver(onErrorJustReturn: [])
    }
}
