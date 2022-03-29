//
//  SignUpPageViewModel+RxSwift.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class RxSignUpPageViewModel {
    private let httpManager = RxUserHttpManager()
    private let disposeBag = DisposeBag()
    let checkIdButtonViewModel = CheckIdButtonViewModel()
    let joinButtonViewModel = JoinButtonViewModel()
    
//    let bodyData: Driver<SignupUser>
    //View -> ViewModel
    let idText = PublishRelay<String>()
    let pwText = PublishRelay<String>()
    let confirmPwText = PublishRelay<String>()
    let nameText = PublishRelay<String>()

    //ViewModel -> View
    let isValidId = BehaviorRelay<Bool>(value: false)
    let isValidPw = BehaviorRelay<Bool>(value: false)
    let isValidConfimPw = BehaviorRelay<Bool>(value: false)
    let isValidName = BehaviorRelay<Bool>(value: false)

    init() {
        let idObservable = idText.share()
        idObservable
            .map { self.checkId($0) }
            .bind(to: self.isValidId)
            .disposed(by: disposeBag)
        idObservable
            .bind(to: joinButtonViewModel.idText)
            .disposed(by: disposeBag)
        
        let pwObservable = pwText.share()
        pwObservable
            .map { self.checkPw($0) }
            .bind(to: self.isValidPw)
            .disposed(by: disposeBag)
        pwObservable
            .bind(to: joinButtonViewModel.pwText)
            .disposed(by: disposeBag)
        
        confirmPwText
            .withLatestFrom(pwText) {
                self.checkConfirmPw($0, $1)
            }
            .bind(to: self.isValidConfimPw)
            .disposed(by: disposeBag)
        
        let nameObservable = nameText
        nameObservable
            .map { self.checkName($0) }
            .bind(to: self.isValidName)
            .disposed(by: disposeBag)
        
        nameObservable
            .bind(to: joinButtonViewModel.nameText)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            isValidPw,
            isValidConfimPw,
            isValidName,
            checkIdButtonViewModel.isValidButton.asObservable()
        ) { $0 && $1 && $2 && $3 }
            .asSignal(onErrorJustReturn: false)
            .emit(to: joinButtonViewModel.isValidSignUp)
            .disposed(by: disposeBag)
    }
    
    func checkId(_ id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]{1,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }

    // 비밀번호 형식 검사
    func checkPw(_ pw: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pw)
    }

    func checkConfirmPw(_ confirmPw: String, _ pw: String) -> Bool {
        return confirmPw == pw
    }

    func checkName(_ name: String) -> Bool {
        let nameRegEx = "[A-Z0-9a-z가-힣._%+-]{1,}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
}
