//
//  SubmitTapView.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/01.
//

import UIKit
import RxCocoa
import RxSwift

class MagnetSubmitTapView: UIView {
    private let minPriceLabel = UILabel()
    private let submitButton = UIButton()
    private let submitTitleLabel = UILabel()
    private let submitPriceLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MagnetSubmitTapViewModel) {
        viewModel.currentPrice
            .bind { price in
                self.submitPriceLabel.text = price.parsingToKoreanPrice()
            }
            .disposed(by: disposeBag)
        
        viewModel.canSubmit
            .bind { canSubmit in
                if (canSubmit == true) {
                    self.submitButton.isEnabled = true
                    self.submitButton.backgroundColor = .systemMint
                } else {
                    self.submitButton.isEnabled = false
                    self.submitButton.backgroundColor = .gray
                }
            }
            .disposed(by: disposeBag)
        
        self.submitButton.rx.tap
            .bind {
                print("click!")
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .white
        
        self.submitButton.layer.cornerRadius = 5
        self.minPriceLabel.font = .systemFont(ofSize: 14, weight: .light)
        self.submitTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        self.submitPriceLabel.font = .systemFont(ofSize: 15, weight: .medium)
        self.submitTitleLabel.textColor = .white
        self.submitPriceLabel.textColor = .white
        
        //Temp
        self.minPriceLabel.text = "배달최소주문금액 23,000원"
        self.minPriceLabel.textColor = .darkGray
        self.submitTitleLabel.text = "1개 담기"
//        self.submitPriceLabel.text = 25000.parsingToKoreanPrice()
    }
    
    private func layout() {
        [minPriceLabel, submitButton].forEach {
            self.addSubview($0)
        }
        
        minPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        submitButton.snp.makeConstraints {
            $0.top.equalTo(minPriceLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(MagnetBarViewMath.windowWidth*0.9)
            $0.bottom.equalToSuperview().offset(-40)
        }
        
        [submitTitleLabel, submitPriceLabel].forEach {
            submitButton.addSubview($0)
        }
        
        submitTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        submitPriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
