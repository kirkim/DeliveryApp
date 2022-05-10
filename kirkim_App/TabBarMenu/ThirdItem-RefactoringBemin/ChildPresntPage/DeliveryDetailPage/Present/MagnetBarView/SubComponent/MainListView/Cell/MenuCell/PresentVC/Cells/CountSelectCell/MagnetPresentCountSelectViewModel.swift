//
//  MagnetPresentCountSelectViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/02.
//

import Foundation
import RxCocoa
import RxSwift

struct MagnetPresentCountSelectViewModel {
    let countCheckerViewModel = CountCheckerViewModel()
    
    // ViewModel -> View
//    let plusMinusButtonClicked: Signal<Int>
    
    // ViewModel -> View
    let totalCount = BehaviorRelay<Int>(value: 1)
    
    private let disposeBag = DisposeBag()
    
    init() {
        countCheckerViewModel.buttonClicked.scan(1) { pre, value in
            let result = pre + value > 0 ? pre + value : 1
            return result
        }
        .bind(to: totalCount)
        .disposed(by: disposeBag)
    }
}
