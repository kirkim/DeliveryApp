//
//  SignUpButton.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/29.
//

import UIKit
import RxSwift
import RxCocoa

class JoinButton: UIButton {
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
    
    func bind(_ viewModel: JoinButtonViewModel) {
        self.rx.tap
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .bind { isValid in
                self.isEnabled = isValid
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.setTitle(" JOIN ", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        self.setTitleColor(.blue, for: .normal)
        self.setTitleColor(.gray, for: .disabled)
        self.isEnabled = false
    }
}
