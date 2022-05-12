//
//  ShoppingBasecketVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import SnapKit
import RxSwift

class ShoppingcartVC: UIViewController {
    private let emptyCartView = EmptyCartView()
    private let cartTableView = CartTableView()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        CartManager.shared.getIsValidObserver()
            .bind { isValid in
                self.cartTableView.isHidden = !isValid
                self.emptyCartView.isHidden = isValid
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.view.backgroundColor = .green
        self.title = "장바구니"
    }
    
    private func layout() {
        [emptyCartView, cartTableView].forEach {
            self.view.addSubview($0)
        }
        
        emptyCartView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        cartTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}
