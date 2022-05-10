//
//  CountCheckerViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/02.
//

import Foundation
import RxCocoa

struct CountCheckerViewModel {
    let buttonClicked = PublishRelay<Int>()
    let totalCount: Signal<Int>
    
    init() {
        self.totalCount = buttonClicked.scan(1) { pre, value in
            let result = pre + value > 0 ? pre + value : 1
            return result
        }
        .asSignal(onErrorJustReturn: 0)
    }
}
