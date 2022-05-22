//
//  JoinButtonViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/29.
//

import Foundation
import RxSwift
import RxCocoa

struct JoinButtonViewModel {
    let httpManager = RxUserHttpManager()
    let disposeBag = DisposeBag()
    
    //View -> ViewModel
    let buttonTapped = PublishRelay<Void>()
    
    //ViewModel -> View
    let isValid = PublishRelay<Bool>()
    let presentAlert = PublishRelay<CustomAlert>()
    
    //ParentViewModel(RxSignupPageViewModel) -> ViewModel
    let postSigUp = PublishRelay<UserData>()
    
    init() {
        buttonTapped
            .withLatestFrom(postSigUp) { $1 }
            .bind(onNext: self.signUp)
            .disposed(by: disposeBag)
    }
    
    private func signUp(userData: UserData) {
        self.httpManager.signUpUser(userData: userData)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                switch result {
                case .success(_):
                    self.presentAlert.accept(CustomAlert(message: "회원가입이 완료되었습니다!", isDismiss: true))
                case .failure(let error):
                    print(error)
                    self.presentAlert.accept(CustomAlert(message: "회원가입에 실패하였습니다!", isDismiss: false))
                }
            }
            .disposed(by: disposeBag)
    }
}
