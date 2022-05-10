//
//  TotalButtonViewModel.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import RxCocoa
import RxSwift
import UIKit

enum BannerButtonType {
    case event
    case basic
}

struct BeminBannerButtonViewModel {
    private let disposeBag = DisposeBag()
    private let totalPage: Int
    private let type: BannerButtonType
    
    // View -> ViewModel
    let nowPage: BehaviorSubject<Int>
    let buttonTapped = PublishRelay<Void>()
    
    // ViewModel -> ParentViewModel
    let tapped: Signal<(Int, BannerButtonType)>
    
    var title: Observable<String> {
        return nowPage
            .map { page in
                switch type {
                case .event:
                    return "    \(page + 1)   /   \(self.totalPage) 모두보기    "
                case .basic:
                    return "    \(page + 1)   /   \(self.totalPage)    "
                }
            }
    }
    
    init(type: BannerButtonType,nowPage: BehaviorSubject<Int>, totalPageCount: Int) {
        self.type = type
        self.nowPage = nowPage
        self.totalPage = totalPageCount
        
        tapped = buttonTapped
            .withLatestFrom(nowPage)
            .map { nowPage in
                return (nowPage, type)
            }
            .asSignal(onErrorJustReturn: (0, .basic) )
    }
}
