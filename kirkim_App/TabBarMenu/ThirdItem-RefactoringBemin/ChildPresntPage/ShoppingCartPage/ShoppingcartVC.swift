//
//  ShoppingBasecketVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import SnapKit

class ShoppingcartVC: UIViewController {
    private let cartTableView = CartTableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.title = "장바구니"
    }
    
    private func layout() {
        [cartTableView].forEach {
            self.view.addSubview($0)
        }
        
        cartTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
