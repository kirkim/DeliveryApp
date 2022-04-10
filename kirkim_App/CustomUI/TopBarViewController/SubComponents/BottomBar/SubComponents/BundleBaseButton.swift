//
//  BundleBaseButton.swift
//  TopBarVC
//
//  Created by 김기림 on 2022/04/09.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BundleBaseButton: UIView {
    private let disposeBag = DisposeBag()
    
    private let button1 = UIButton()
    private let button2 = UIButton()
    private let button3 = UIButton()
    private let button4 = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: bind function
    func bind(_ viewModel: BundleBaseButtonViewModel) {
        button1.rx.tap
            .map { .one }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        button2.rx.tap
            .map { .two }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        button3.rx.tap
            .map { .three }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        button4.rx.tap
            .map { .four }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
    }
    
    //MARK: attribute(), layout() function
    private func attribute() {
        self.backgroundColor = .white
        self.button1.backgroundColor = .systemCyan
        self.button2.backgroundColor = .yellow
        self.button3.backgroundColor = .green
        self.button4.backgroundColor = .systemBrown
    
    }
    
    private func layout() {
        [button1, button2, button3, button4].forEach {
            self.addSubview($0)
        }
        
        button1.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.22)
        }
        
        button2.snp.makeConstraints {
            $0.leading.equalTo(button1.snp.trailing)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.22)
        }
        
        button3.snp.makeConstraints {
            $0.trailing.equalTo(button4.snp.leading)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.22)
        }
        
        button4.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.22)
            $0.top.bottom.trailing.equalToSuperview()
        }
    }
}
