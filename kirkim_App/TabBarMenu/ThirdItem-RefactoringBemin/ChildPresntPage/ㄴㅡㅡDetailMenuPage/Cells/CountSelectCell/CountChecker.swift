//
//  CountChecker.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/01.
//

import UIKit
import RxCocoa
import RxSwift

class CountCheckerView: UIView {
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let countLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CountCheckerViewModel) {
        self.plusButton.rx.tap
            .map { 1 }
            .bind(to: viewModel.buttonClicked)
            .disposed(by: disposeBag)
        
        self.minusButton.rx.tap
            .map { -1 }
            .bind(to: viewModel.buttonClicked)
            .disposed(by: disposeBag)
        
        viewModel.totalCount
            .emit { value in
                self.countLabel.text = "\(value)개"
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        self.minusButton.tintColor = .black
        self.plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        self.plusButton.tintColor = .black
        self.countLabel.text = "1개"
        self.countLabel.textAlignment = .center
        
    }
    
    private func layout() {
        [minusButton, countLabel, plusButton].forEach {
            self.addSubview($0)
        }
        
        minusButton.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(minusButton.snp.trailing)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
        
        plusButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
    }
}
