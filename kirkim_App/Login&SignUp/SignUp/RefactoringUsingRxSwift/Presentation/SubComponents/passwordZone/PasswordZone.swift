//
//  passwordZone.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PasswordZone: UIView {
    private let pwTextField = SimpleTextField(type: .password)
    private let pwErrorMessage = SignUpErrorLabel()
    private let confirmPwTextField = SimpleTextField(type: .password)
    private let confirmPwErrorMessage = SignUpErrorLabel()
    
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
    func bind(_ viewModel: PasswordZoneViewModel) {
        self.pwTextField.rx.text.orEmpty
            .bind(to: viewModel.pwText)
            .disposed(by: disposeBag)
        
        self.confirmPwTextField.rx.text.orEmpty
            .bind(to: viewModel.conformPwText)
            .disposed(by: disposeBag)
        
        viewModel.isValidPw
            .emit { [weak self] isValid in
                self?.pwErrorMessage.isHidden = isValid
            }
            .disposed(by: disposeBag)
        
        viewModel.isValidConfirmPw
            .emit { [weak self] isValid in
                self?.confirmPwErrorMessage.isHidden = isValid
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - attribute, layout function
    private func attribute() {
        pwErrorMessage.text = "유효한 비밀번호를 입력해 주세요"
        confirmPwErrorMessage.text = "동일한 비밀번호를 입력해 주세요"
        self.pwTextField.placeholder = "비밀번호"
        self.confirmPwTextField.placeholder = "비밀번호 확인"
    }
    
    private func layout() {
        [pwTextField, pwErrorMessage, confirmPwTextField, confirmPwErrorMessage].forEach {
            self.addSubview($0)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        pwErrorMessage.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        confirmPwTextField.snp.makeConstraints {
            $0.top.equalTo(pwErrorMessage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        confirmPwErrorMessage.snp.makeConstraints {
            $0.top.equalTo(confirmPwTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }

        self.snp.makeConstraints {
            $0.bottom.equalTo(confirmPwErrorMessage.snp.bottom)
        }
    }
}
