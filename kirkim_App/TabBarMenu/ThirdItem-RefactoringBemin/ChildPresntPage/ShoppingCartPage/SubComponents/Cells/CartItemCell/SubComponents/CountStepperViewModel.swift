//
//  CountStepperViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import Foundation
import RxCocoa
import RxSwift

struct CountStepperViewModel {
    let buttonClicked = PublishRelay<Int>()
//    let totalCount: Signal<Int>
    let totalCount = BehaviorRelay<Int>(value: 1)
    let totalCountChanged = PublishRelay<Int>()
    let disposeBag = DisposeBag()
    
    init() {
        let clickStream = buttonClicked.withLatestFrom(totalCount, resultSelector: { value, totalCount -> Int in
            if (value + totalCount <= 0) {
                return 1
            }
            return value + totalCount
        })
            .share()
        clickStream
            .bind(to: totalCount)
            .disposed(by: disposeBag)
        
        clickStream
            .bind(to: totalCountChanged)
            .disposed(by: disposeBag)
    }
    
    func setCount(count: Int) {
        self.totalCount.accept(count)
    }
}
