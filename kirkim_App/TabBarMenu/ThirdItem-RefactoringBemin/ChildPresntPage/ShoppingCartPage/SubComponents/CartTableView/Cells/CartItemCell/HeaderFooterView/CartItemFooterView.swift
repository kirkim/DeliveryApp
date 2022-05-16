//
//  CartItemFooterView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/12.
//

import UIKit
import SnapKit
import Reusable
import RxGesture
import RxSwift

class CartItemFooterView: UITableViewHeaderFooterView, Reusable {
    private let titleLabel = UILabel()
    private let disposeBag = DisposeBag()
    private var flag:Bool = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
            self.titleLabel.rx.tapGesture()
                .when(.recognized)
                .bind(to: CartManager.shared.presentStoreVC)
                .disposed(by: disposeBag)
    }
    
    private func attribute() {
        titleLabel.text = "+ 더 담으러 가기"
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    private func layout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
