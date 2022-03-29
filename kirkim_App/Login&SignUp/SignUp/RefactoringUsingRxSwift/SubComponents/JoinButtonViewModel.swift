//
//  JoinButtonViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/29.
//

import Foundation
import RxSwift
import RxCocoa

class JoinButtonViewModel {
    let httpManager = RxUserHttpManager()
    let disposeBag = DisposeBag()
    
    //View -> ViewModel
    let buttonTapped = PublishRelay<Void>()
    
    //ViewModel -> View
    let isValidSignUp = PublishRelay<Bool>()
    let presentAlert = PublishRelay<String>()
    let succeedSignUp = PublishRelay<Bool>()
    
    let idText = PublishRelay<String>()
    let pwText = PublishRelay<String>()
    let nameText = PublishRelay<String>()
    
    init() {
        let userData = Observable.combineLatest(
            idText,
            pwText,
            nameText
        ) { UserData(userID: $0, password: $1, name: $2) }
        
        buttonTapped
            .withLatestFrom(userData) { $1 }
            .bind(onNext: self.signUp)
            .disposed(by: disposeBag)

    }
    
    private func signUp(userData: UserData) {
        self.httpManager.signUpUser(userData: userData)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                switch result {
                case .success(_):
                    self.presentAlert.accept("회와가입이 완료되었습니다!")
                    self.succeedSignUp.accept(true)
                case .failure(let error):
                    print(error)
                    self.presentAlert.accept("회와가입에 실패하였습니다!")
                    self.succeedSignUp.accept(false)
                }
            }
            .disposed(by: disposeBag)
    }
}
