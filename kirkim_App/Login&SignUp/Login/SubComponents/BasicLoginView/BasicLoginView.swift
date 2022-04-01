//
//  BasicLoginVC.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import UIKit
import SnapKit

class BasicLoginView: UIView {
    let idZone = LoginIdZone()
    let passwordZone = LoginPwZone()
    let loginButton = LoginButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: BasicLoginViewModel) {
        let idZoneViewModel = viewModel.idZoneViewModel
        let pwZoneViewModel = viewModel.pwZoneViewModel
        let loginButtonViewModel = viewModel.loginButtonViewModel
        
        self.idZone.bind(idZoneViewModel)
        self.passwordZone.bind(pwZoneViewModel)
        self.loginButton.bind(loginButtonViewModel)
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        [idZone, passwordZone, loginButton].forEach {
            self.addSubview($0)
        }
        
        idZone.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        passwordZone.snp.makeConstraints {
            $0.top.equalTo(idZone.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordZone.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.bottom)
        }
    }
}
