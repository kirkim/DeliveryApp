//
//  LoginPwZone.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginPwZone: UIView {
    private let pwTextField = SimpleTextField(type: .normal)
    private let pwErrorMessage = LoginErrorLabel()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - init function
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - bind function
    func bind(_ viewModel: LoginPwZoneViewModel) {
        self.pwTextField.rx.text.orEmpty
            .bind(to: viewModel.pwText)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .emit { isValid in
                self.pwErrorMessage.isHidden = isValid
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - attribute, layout function
    private func attribute() {
        pwErrorMessage.text = "유효한 비밀번호 입력해 주세요"
        self.pwTextField.placeholder = "Password"
    }
    
    private func layout() {
        [pwTextField, pwErrorMessage].forEach {
            self.addSubview($0)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        pwErrorMessage.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }

        self.snp.makeConstraints {
            $0.bottom.equalTo(pwErrorMessage.snp.bottom)
        }
    }
}
