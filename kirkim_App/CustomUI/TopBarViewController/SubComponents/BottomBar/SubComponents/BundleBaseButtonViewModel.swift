//
//  BundleBaseButtonViewModel.swift
//  TopBarVC
//
//  Created by 김기림 on 2022/04/09.
//

import RxCocoa
import RxSwift
import UIKit

enum ButtonType {
    case one, two, three, four
}

struct BundleBaseButtonViewModel {
    private let disposeBag = DisposeBag()
    //View -> ViewModel
    let buttonTapped = PublishRelay<ButtonType>()
    
    // ViewModel -> ParentViewModel
    let presentVC = PublishRelay<UIViewController>()
    
    init(bottomBarItem: BottomBarItem) {
        buttonTapped
            .map { buttonType in
                switch buttonType {
                case .one:
                    return bottomBarItem.presentVC1
                case .two:
                    return bottomBarItem.presentVC2
                case .three:
                    return bottomBarItem.presentVC3
                case .four:
                    return bottomBarItem.presentVC4
                }
            }
            .bind(to: presentVC)
            .disposed(by: disposeBag)
    }
}
