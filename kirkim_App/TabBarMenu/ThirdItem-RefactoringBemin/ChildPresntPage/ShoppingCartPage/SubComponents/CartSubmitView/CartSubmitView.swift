//
//  CartSubmitView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/17.
//

import UIKit
import SnapKit
import RxGesture
import RxSwift

class CartSubmitView: UIView {
    private let titleLabel = UILabel()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        let cartManager = CartManager.shared
        cartManager.getCanSubmitObserver()
            .bind { isValid in
                if (isValid == true) {
                    self.backgroundColor = .brown
                    self.titleLabel.text = "\(cartManager.getTotalPrice() + cartManager.getDeliveryTip())원 배달 주문하기"
                } else {
                    self.backgroundColor = .systemGray3
                    self.titleLabel.text = "\(cartManager.getMinPrice())원부터 주문할 수 있어요"
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .systemGray
        self.layer.cornerRadius = 10
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        
        //temp
//        self.titleLabel.text = "15000원부터 주문할 수 있어요"
    }
    
    private func layout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
