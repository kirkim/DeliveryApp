//
//  CheckIdButton.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/29.
//

import UIKit
import RxSwift
import RxCocoa

class ChekcIdButton: UIButton {
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
    
    func bind(_ viewModel: CheckIdButtonViewModel) {
        self.rx.tap
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.setTitle(" 중복확인 ", for: .normal)
        self.backgroundColor = .brown
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        self.layer.cornerRadius = 13
    }
}
