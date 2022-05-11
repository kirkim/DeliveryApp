//
//  CartTypeCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import RxGesture

class CartTypeCell: UITableViewCell, Reusable {
    private let toggleTypeLabel = UILabel()
    private let subLabel = UILabel()
    private let disposeBag = DisposeBag()
    private var flag:Bool = false
    private var type: ShoppingCartType = .delivery
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(type: ShoppingCartType) {
        self.type = type
        self.setToggleLabel(type: type)
    }
    
    func setToggleLabel(type: ShoppingCartType) {
        if (type == .delivery) {
            self.toggleTypeLabel.text = "배달 ▾"
        } else {
            self.toggleTypeLabel.text = "포장 ▾"
        }
    }
    
    func bind(_ viewModel: CartTypeViewModel) {
        if (flag == false) {
            flag = true
            toggleTypeLabel.rx.tapGesture()
                .when(.recognized)
                .map({ _ in
                    return self.type
                })
                .bind(to: viewModel.tappedTypeLabel)
                .disposed(by: disposeBag)
        }
    }
    
    private func attribute() {
        self.selectionStyle = .none
        self.subLabel.text = "로 받을게요"
        self.toggleTypeLabel.font = .systemFont(ofSize: 25, weight: .medium)
    }
    
    private func layout() {
        [toggleTypeLabel, subLabel].forEach {
            self.addSubview($0)
        }
        
        toggleTypeLabel.snp.makeConstraints {
            $0.leading.equalTo(15)
            $0.centerY.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints {
            $0.leading.equalTo(toggleTypeLabel.snp.trailing).offset(3)
            $0.centerY.equalToSuperview()
        }
    }
}
