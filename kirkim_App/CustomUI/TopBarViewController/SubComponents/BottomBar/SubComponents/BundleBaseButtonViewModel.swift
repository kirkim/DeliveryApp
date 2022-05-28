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
    
    // ViewModel -> View
    private let buttonDatas: BottomBarDatas
    
    init(bottomBarItems: BottomBarItems) {
        let presentVCBundle = bottomBarItems.presentVC
        buttonTapped
            .map { buttonType in
                switch buttonType {
                case .one:
                    return presentVCBundle.button1
                case .two:
                    return presentVCBundle.button2
                case .three:
                    return presentVCBundle.button3
                case .four:
                    return presentVCBundle.button4
                }
            }
            .bind(to: presentVC)
            .disposed(by: disposeBag)
        self.buttonDatas = bottomBarItems.datas
    }
    
    func getButtonDatas() -> BottomBarDatas {
        return self.buttonDatas
    }
}
