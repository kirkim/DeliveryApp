//
//  LoginButton.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import UIKit
import RxSwift
import RxCocoa

class LoginButton: UIButton {
    private let disposeBag = DisposeBag()
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: LoginButtonViewModel) {
        self.rx.tap
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.setTitle(" LOGIN ", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        self.setTitleColor(.brown, for: .normal)
        self.setTitleColor(.gray, for: .disabled)
    }
}
