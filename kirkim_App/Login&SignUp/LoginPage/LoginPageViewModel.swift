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
    let basicLoginViewModel = BasicLoginViewModel()
    let createUserButtonViewModel = CreateUserButtonViewModel()
    
    let disposeBag = DisposeBag()
    
    //View -> ViewModel
    
    //ViewModel -> View
    let clickedLoginButton: Signal<LoginStatus>
    
    init() {
        clickedLoginButton = basicLoginViewModel.clickedLoginButton
    }
}
