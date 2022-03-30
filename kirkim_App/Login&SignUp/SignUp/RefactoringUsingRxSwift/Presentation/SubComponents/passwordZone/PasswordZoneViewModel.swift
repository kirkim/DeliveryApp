//
//  PasswordZoneViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/30.
//

import Foundation
import RxSwift
import RxCocoa

struct PasswordZoneViewModel {
    //View -> ViewModel
    let pwText = PublishRelay<String>()
    let conformPwText = PublishRelay<String>()
    
    //ViewModel -> View
    let isValid: Signal<Bool>
    let isValidPw: Signal<Bool>
    let isValidConfirmPw: Signal<Bool>
    
    init() {
        isValidPw = pwText
            .map { pw -> Bool in
                let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
                let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
                return passwordTest.evaluate(with: pw)
            }
            .asSignal(onErrorJustReturn: false)
        
        isValidConfirmPw = Observable.combineLatest(
            pwText,
            conformPwText
        ) { $0 == $1}
            .asSignal(onErrorJustReturn: false)
        
        isValid = Signal
            .combineLatest(
                isValidPw,
                isValidConfirmPw
            ) { $0 && $1 }
            .asSignal()
    }
}
