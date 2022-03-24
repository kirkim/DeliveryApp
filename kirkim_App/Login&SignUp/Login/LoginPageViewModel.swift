//
//  LoginPageViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/23.
//

import UIKit
import RxSwift
import RxCocoa

struct LoginPageViewModel {
    let disposeBag = DisposeBag()
    
    //View -> ViewModel
    let idText = PublishRelay<String?>()
    let pwText = PublishRelay<String?>()
    
    //ViewModel -> View
    let isValidId: Signal<Bool>
    let isValidPw: Signal<Bool>
    let isValidLogin: Signal<Bool>
    
    init() {
        self.isValidId = idText.map { id -> Bool in
            return id != ""
        }
        .asSignal(onErrorJustReturn: false)
        
        self.isValidPw = pwText.map { pw -> Bool in
            return pw != ""
        }
        .asSignal(onErrorJustReturn: false)
        
        self.isValidLogin = SharedSequence
            .combineLatest(
                isValidId,
                isValidPw
            ) { $0 && $1 }
    }
    
    private func checkIDValid(_ id: String?) -> Bool {
        return true
    }
    
    private func checkPasswordValid(_ password: String?) -> Bool {
        return true
    }
}
