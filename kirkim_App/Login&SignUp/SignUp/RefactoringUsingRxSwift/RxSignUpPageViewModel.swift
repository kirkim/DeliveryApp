//
//  SignUpPageViewModel+RxSwift.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/24.
//

import Foundation
import RxSwift
import RxCocoa
import CoreAudio
import CoreMedia
import simd

struct RxSignUpPageViewModel {
    private let httpManager = RxUserHttpManager()
    private let disposeBag = DisposeBag()
    
    let bodyData: Driver<SignupUser>
    //View -> ViewModel
    let idText = PublishRelay<String>()
    let pwText = PublishRelay<String>()
    let confirmPwText = PublishRelay<String>()
    let nameText = PublishRelay<String>()
    let signupButtonTapped = PublishRelay<Void>()
    
    //ViewModel -> View
//    let isValidId: Signal<Bool>
//    let isValidPw: Signal<Bool>
//    let isValidConfirmPw: Signal<Bool>
//    let isValidName: Signal<Bool>
    let presentAlert = Signal<String>()
    
    init() {
        isValidId = idText.map { id -> Bool in
            let emailRegEx = "[A-Z0-9a-z._%+-]{1,}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: id)
        }
        .asSignal(onErrorJustReturn: false)
        
        isValidPw = pwText.map { pw -> Bool in
            let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            return passwordTest.evaluate(with: pw)
        }
        .asSignal(onErrorJustReturn: false)
        
        isValidConfirmPw = confirmPwText.withLatestFrom(pwText) { pw, confirmPw in
            return pw == confirmPw
        }
        .asSignal(onErrorJustReturn: false)
        
        isValidName = nameText.map { name -> Bool in
            let nameRegEx = "[A-Z0-9a-z가-힣._%+-]{1,}"
            let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
            return nameTest.evaluate(with: name)
        }
        .asSignal(onErrorJustReturn: false)
        
        let isValidSignUp = Signal
            .combineLatest(
                isValidId,
                isValidPw,
                isValidConfirmPw,
                isValidName
            ) { $0 && $1 && $2 && $3 }
            
        bodyData = Observable
            .combineLatest(
                idText,
                pwText,
                confirmPwText,
                nameText
            ) { SignupUser(userID: $0, password: $1, confirmPassword: $2, name: $3) }
            .asDriver(onErrorDriveWith: .empty())
        
        let errorMessage = Signal
            .combineLatest(
                isValidId,
                isValidPw,
                isValidConfirmPw,
                isValidName
            )
            .map { (validId, validPw, validCPw, validName) -> String? in
                var message:[String] = []
                if (!validId) {
                    message.append("- 유효한 아이디를 입력해 주세요.")
                }
                if (!validPw) {
                    message.append("- 유효한 비밀번호를 입력해 주세요.")
                }
                if (!validCPw) {
                    message.append("- 확인비밀번호가 일치하지 않습니다.")
                }
                if (!validName) {
                    message.append("- 유효한 이름을 입력해 주세요.")
                }
                return message.isEmpty ? nil : message.joined(separator: "\n")
            }
        
        self.presentAlert = self.signupButtonTapped
            .withLatestFrom(errorMessage)
            .filter({ message in
                if (message == nil ) {
                    httpManager.postFetch(type: .signUp, body: )
                }
            })
    }
    func isValidUserID(_ id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]{1,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사
    func isValidPw(_ pw: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    func isValidConfirmPw(_ pw: String, _ confirmPw: String) -> Bool {
        return pw == confirmPw
    }
    
    func isValidName(_ name: String) -> Bool {
        let nameRegEx = "[A-Z0-9a-z가-힣._%+-]{1,}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
    
    //    func signup(signupData: SignupUser, completion: @escaping (ValidatorResult) -> Void) {
//        let checkUserResult = checkUserData(checkData: signupData)
//        if ( checkUserResult != .success) {
//            completion(checkUserResult)
//            return
//        } else {
//            userHttpManager.postFetch(type: .signUp, body: signupData, completion: { result in
//                switch result {
//                case .success(_):
//                    completion(.success)
//                    break;
//                case .failure(let error):
//                    completion(.httpError)
//                    print(error)
//                }
//            })
//        }
//    }
}
