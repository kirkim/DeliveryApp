//
//  NameZone.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NameZone: UIView {
    private let nameTextField = SimpleTextField(type: .normal)
    private let nameErrorMessage = SignUpErrorLabel()

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
    func bind(_ viewModel: NameZoneViewModel) {
        self.nameTextField.rx.text.orEmpty
            .bind(to: viewModel.nameText)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .emit { [weak self] isValid in
                self?.nameErrorMessage.isHidden = isValid
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - attribute, layout function
    private func attribute() {
        nameErrorMessage.text = "유효한 이름을 입력해 주세요"
        self.nameTextField.placeholder = "이름"
    }
    
    private func layout() {
        [nameTextField, nameErrorMessage].forEach {
            self.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        nameErrorMessage.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }

        self.snp.makeConstraints {
            $0.bottom.equalTo(nameErrorMessage.snp.bottom)
        }
    }
}

