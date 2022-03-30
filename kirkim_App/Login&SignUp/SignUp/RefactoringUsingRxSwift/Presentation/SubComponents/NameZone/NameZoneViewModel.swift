//
//  NameZoneViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/30.
//

import Foundation
import RxSwift
import RxCocoa

struct NameZoneViewModel {
    //View -> ViewModel
    let nameText = PublishRelay<String>()
    
    //ViewModel -> View
    let isValid: Signal<Bool>
    
    init() {
        isValid = nameText
            .map { name -> Bool in
                let nameRegEx = "[A-Z0-9a-z가-힣._%+-]{1,}"
                let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
                return nameTest.evaluate(with: name)
            }
            .asSignal(onErrorJustReturn: false)
    }
}
