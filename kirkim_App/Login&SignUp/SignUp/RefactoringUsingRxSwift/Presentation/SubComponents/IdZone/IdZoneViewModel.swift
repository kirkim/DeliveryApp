//
//  IdZoneViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/30.
//

import Foundation
import RxSwift
import RxCocoa

struct IdZoneViewModel {
    let disposBag = DisposeBag()
    let checkIdButtonViewModel = CheckIdButtonViewModel()
    //View -> ViewModel
    let idText = PublishRelay<String>()
    
    //ViewModel -> View
    let isValidId: Signal<Bool>
    let isValid: Signal<Bool>
    let presentAlert: Signal<String>
    
    init() {
        isValidId = idText
            .map { id -> Bool in
                let emailRegEx = "[A-Z0-9a-z._%+-]{1,}"
                let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: id)
            }
            .asSignal(onErrorJustReturn: false)
        
        presentAlert = checkIdButtonViewModel.presentAlert
            .asSignal()
        
        isValid = checkIdButtonViewModel.isValidButton
            .asSignal()
        
        idText
            .bind(to: checkIdButtonViewModel.checkValue)
            .disposed(by: disposBag)
    }
}
