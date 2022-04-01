//
//  LoginIdZoneViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//
import Foundation
import RxCocoa

struct LoginIdZoneViewModel {
    //View -> ViewModel
    let idText = PublishRelay<String>()
    
    //ViewModel -> View
    let isValid: Signal<Bool>
    
    init() {
        isValid = idText
            .map({ id -> Bool in
                let emailRegEx = "[A-Z0-9a-z._%+-]{1,}"
                let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: id)
            })
            .asSignal(onErrorJustReturn: false)
    }
}
