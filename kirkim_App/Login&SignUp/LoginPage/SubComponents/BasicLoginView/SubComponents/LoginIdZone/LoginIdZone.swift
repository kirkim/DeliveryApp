//
//  LoginIdZone.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginIdZone: UIView {
    private let idTextField = SimpleTextField(type: .normal)
    private let idErrorMessage = LoginErrorLabel()
    
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
    func bind(_ viewModel: LoginIdZoneViewModel) {
        idTextField.rx.text.orEmpty
            .bind(to: viewModel.idText)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .emit { isValid in
                self.idErrorMessage.isHidden = isValid
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - attribute, layout function
    private func attribute() {
        idErrorMessage.text = "유효한 아이디를 입력해 주세요"
        idErrorMessage.font = .systemFont(ofSize: 13, weight: .light)
        idErrorMessage.textColor = .systemRed
        self.idTextField.placeholder = "ID"
    }
    
    private func layout() {
        [idTextField, idErrorMessage].forEach {
            self.addSubview($0)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        idErrorMessage.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }

        self.snp.makeConstraints {
            $0.bottom.equalTo(idErrorMessage.snp.bottom)
        }
    }
    
}
