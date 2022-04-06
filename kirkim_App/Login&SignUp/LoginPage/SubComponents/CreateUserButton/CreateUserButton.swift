//
//  CreateUserButton.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/01.
//

import UIKit
import RxSwift
import RxCocoa

class CreateUserButton: UIButton {
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
    
    func bind(_ viewModel: CreateUserButtonViewModel) {
        self.rx.tap.bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.setTitle(" 회원가입 → ", for: .normal)
        self.setTitleColor(.brown, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
    }
}
