//
//  BasicLoginViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import Foundation
import RxSwift
import RxCocoa

struct BasicLoginViewModel {
    private let disposeBag = DisposeBag()
    
    //subComponent ViewModel
    let idZoneViewModel = LoginIdZoneViewModel()
    let pwZoneViewModel = LoginPwZoneViewModel()
    let loginButtonViewModel = LoginButtonViewModel()
    
    //ViewModel -> View
    let clickedLoginButton: Signal<LoginStatus>
    
    init() {
        let loginUserData = Observable.combineLatest(
            idZoneViewModel.idText.share(),
            pwZoneViewModel.pwText.share()
        ) { LoginUser(userID: $0, password: $1) }
            .asSignal(onErrorJustReturn: LoginUser(userID: "", password: ""))
        
        SharedSequence.combineLatest(
            idZoneViewModel.isValid,
            pwZoneViewModel.isValid
        ) { $0 && $1 }
            .filter { $0 }
            .withLatestFrom(loginUserData)
            .emit(to: loginButtonViewModel.postLogin)
            .disposed(by: disposeBag)
        
        clickedLoginButton = loginButtonViewModel.clicked
            .asSignal()
    }
}
