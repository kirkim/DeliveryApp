//
//  TestViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/30.
//

import Foundation
import RxSwift
import RxCocoa

class RxSignUpPageViewModel {
    private let disposeBag = DisposeBag()
    let disMissView: Bool = false
    
    //subComponent ViewModel
    let idZoneViewModel = IdZoneViewModel()
    let pwZoneViewModel = PasswordZoneViewModel()
    let nameZoneViewModel = NameZoneViewModel()
    let joinButtonModel = JoinButtonViewModel()
    
    //ViewModel -> View
    let presentAlert = PublishRelay<CustomAlert>()
    
    init() {
        let signupUserData = Observable.combineLatest(
            idZoneViewModel.idText.share(),
            pwZoneViewModel.pwText.share(),
            nameZoneViewModel.nameText.share()
        ) {  UserData(userID: $0, password: $1, name: $2) }
            .asSignal(onErrorJustReturn:  UserData(userID: "", password: "", name: ""))
        
        SharedSequence.combineLatest(
            idZoneViewModel.isValid,
            pwZoneViewModel.isValid,
            nameZoneViewModel.isValid
        ) { $0 && $1 && $2 }
            .filter { isValidSignUp in
                self.joinButtonModel.isValidSignUp.accept(isValidSignUp)
                return isValidSignUp
            } // 모든유효성검사가 참일때 데이터를 전달
            .withLatestFrom(signupUserData)
            .emit(to: joinButtonModel.postSigUp)
            .disposed(by: disposeBag)
        
        idZoneViewModel.presentAlert
            .emit { [weak self] message in
                self?.presentAlert.accept(message)
            }
            .disposed(by: disposeBag)
        
        joinButtonModel.presentAlert
            .subscribe(onNext: { [weak self]message in
                self?.presentAlert.accept(message)
            })
            .disposed(by: disposeBag)        
        }
}
