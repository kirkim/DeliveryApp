//
//  LoginButtonViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginButtonViewModel {
    let user = UserModel()
    let disposeBag = DisposeBag()
    
    //View -> ViewModel
    let buttonTapped = PublishRelay<Void>()
    
    //ViewModel -> View
    let clicked = PublishRelay<LoginStatus>()
    
    //ParentViewModel(RxLoginPageViewModel) -> ViewModel
    let postLogin = PublishRelay<LoginUser>()
    
    init() {
        buttonTapped
            .withLatestFrom(postLogin) { $1 }
            .bind(onNext: self.logIn)
            .disposed(by: disposeBag)
    }
    
    private func logIn(loginUser: LoginUser) {
        self.user.logIn(loginUserData: loginUser)
            .subscribe { error in
                guard error != nil else {
                    clicked.accept(.success)
                    return
                }
                clicked.accept(.fail(message: "아이디 혹은 비밀번호를 확인하세요."))
            } onFailure: { error in
                clicked.accept(.fail(message: error.localizedDescription))
            }
            .disposed(by: disposeBag)
    }
    
}

