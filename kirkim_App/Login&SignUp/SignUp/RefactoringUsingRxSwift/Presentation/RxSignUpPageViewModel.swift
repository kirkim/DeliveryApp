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
    let presentAlert = BehaviorRelay<String>(value: "d")
    
    init() {
        SharedSequence.combineLatest(
            idZoneViewModel.isValid,
            pwZoneViewModel.isValid,
            nameZoneViewModel.isValid
        ) { $0 && $1 && $2 }
            .asSignal(onErrorJustReturn: false)
            .emit(to: joinButtonModel.isValidSignUp)
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
            
        idZoneViewModel.idText.share()
            .bind(to: joinButtonModel.idText)
            .disposed(by: disposeBag)
        
        pwZoneViewModel.pwText.share()
            .bind(to: joinButtonModel.pwText)
            .disposed(by: disposeBag)

        nameZoneViewModel.nameText.share()
            .bind(to: joinButtonModel.nameText)
            .disposed(by: disposeBag)
    }
}
