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
import RxGesture

class BundleBaseButton: UIView {
    private let disposeBag = DisposeBag()
    
    private let button1 = BottomButtonView()
    private let button2 = BottomButtonView()
    private let button3 = BottomButtonView()
    private let button4 = BottomButtonView()
    
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
        button1.rx.tapGesture()
            .when(.recognized)
            .map { _ in .one }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        button2.rx.tapGesture()
            .when(.recognized)
            .map { _ in .two }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        button3.rx.tapGesture()
            .when(.recognized)
            .map { _ in .three }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        button4.rx.tapGesture()
            .when(.recognized)
            .map { _ in .four }
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        let buttonDatas = viewModel.getButtonDatas()
        self.button1.setData(data: buttonDatas.button1)
        self.button2.setData(data: buttonDatas.button2)
        self.button3.setData(data: buttonDatas.button3)
        self.button4.setData(data: buttonDatas.button4)
    }
    
    //MARK: attribute(), layout() function
    private func attribute() {
        self.backgroundColor = .white
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
