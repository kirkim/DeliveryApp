//
//  CreateUserButtonViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/01.
//

import RxCocoa
import RxSwift
import UIKit

struct CreateUserButtonViewModel {
    // View -> ViewModel
    let buttonTapped = PublishRelay<Void>()
    
    // ViewModel -> ParentView
    let presentVC: Signal<UIViewController>
    
    init() {
        let createVC = Observable.just { () -> UIViewController in
            let createVC = RxSignupPageVC()
            createVC.bind(RxSignupPageViewModel())
            return createVC
        }
        
        presentVC = buttonTapped
            .withLatestFrom(createVC) { $1() }
            .asSignal(onErrorJustReturn: UIViewController())
    }
}
