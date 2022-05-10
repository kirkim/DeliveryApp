//
//  CountStepperViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import Foundation
import RxCocoa

struct CountStepperViewModel {
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
