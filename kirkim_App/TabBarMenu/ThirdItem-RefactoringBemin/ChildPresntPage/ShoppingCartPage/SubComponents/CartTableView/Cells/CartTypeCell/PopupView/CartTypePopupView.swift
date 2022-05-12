//
//  CartTypePopupView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CartTypePopupView: UIView {
    private let backgroundTapButton = UIButton()
    private let container = UIStackView()
    private let pickTitle = UILabel()
    private let delieveryTypeButton = UIButton()
    private let takeoutTypeButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CartTypePopupViewModel) {
        self.delieveryTypeButton.rx.tap
            .map { ShoppingCartType.delivery }
            .bind(to: viewModel.selectedCartType)
            .disposed(by: disposeBag)
        
        self.takeoutTypeButton.rx.tap
            .map { ShoppingCartType.takeout }
            .bind(to: viewModel.selectedCartType)
            .disposed(by: disposeBag)
        
        viewModel.selectedCartType.share()
            .bind { type in
                [self.delieveryTypeButton, self.takeoutTypeButton].forEach {
                    $0.backgroundColor = .white
                    $0.setTitleColor(.black, for: .normal)
                }
                switch type {
                case .delivery:
                    self.delieveryTypeButton.backgroundColor = .brown
                    self.delieveryTypeButton.setTitleColor(.white, for: .normal)
                case .takeout:
                    self.takeoutTypeButton.backgroundColor = .brown
                    self.takeoutTypeButton.setTitleColor(.white, for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        self.backgroundTapButton.rx.tap
            .bind {
                self.isHidden = true
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.container.layer.borderWidth = 2
        self.container.layer.cornerRadius = 20
        self.container.layer.masksToBounds = true
        self.container.backgroundColor = .systemGray5
        self.container.distribution = .fillEqually
        self.container.axis = .vertical
        self.container.spacing = 5
        self.container.addArrangedSubview(self.pickTitle)
        self.pickTitle.text = "수령방법"
        self.pickTitle.backgroundColor = .systemGray5
        self.pickTitle.font = .systemFont(ofSize: 25, weight: .bold)
        self.pickTitle.textAlignment = .center
        [self.delieveryTypeButton, self.takeoutTypeButton].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
            self.container.addArrangedSubview($0)
        }
        
        self.delieveryTypeButton.setTitle("배달", for: .normal)
        self.takeoutTypeButton.setTitle("포장", for: .normal)
    }
    
    private func layout() {
        [container, backgroundTapButton].forEach {
            self.addSubview($0)
        }
        
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        backgroundTapButton.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(container.snp.top)
        }
    }
}
