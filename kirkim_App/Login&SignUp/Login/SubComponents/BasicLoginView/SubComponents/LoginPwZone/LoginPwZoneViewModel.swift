//
//  LoginPwZoneViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import Foundation
import RxCocoa

struct LoginPwZoneViewModel {
    //View -> ViewModel
    let pwText = PublishRelay<String>()
    
    //ViewModel -> View
    let isValid: Signal<Bool>
    
    init() {
        isValid = pwText
            .map({ pw -> Bool in
                let emailRegEx = "[A-Z0-9a-z._%+-]{1,}"
                let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: pw)
            })
            .asSignal(onErrorJustReturn: false)
    }

}
