//
//  SortSlideBarViewModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/07.
//

import Foundation
import RxCocoa
import RxSwift

struct SortSlideBarViewModel {
    private let disposeBag = DisposeBag()
    let cellData: [String]

    // View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    
    // ViewModel -> View
    let slotChanged = PublishRelay<Int>()
    
    init() {
        cellData = SortSlideType.allCases
            .map { $0.title }
        itemSelected.bind(to: slotChanged).disposed(by: disposeBag)
    }
}
