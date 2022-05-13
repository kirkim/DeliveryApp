//
//  CartPriceCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class CartPriceCell: UITableViewCell, Reusable {
    private let menuTitleLabel = UILabel()
    private let deliveryTitleLabel = UILabel()
    private let totalTitleLabel = UILabel()
    
    private let menuPriceLabel = UILabel()
    private let deliveryPriceLabel = UILabel()
    private let lineView = UILabel()
    private let totalPriceLabel = UILabel()
    
    private let cartManager = CartManager.shared
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: CartPriceItem) {
        self.deliveryPriceLabel.text = data.deliveryTip.parsingToKoreanPrice()
        self.menuPriceLabel.text = data.menuPrice.parsingToKoreanPrice()
        self.totalPriceLabel.text = (data.deliveryTip + data.menuPrice).parsingToKoreanPrice()
    }
    
    private func attribute() {
        self.selectionStyle = .none
        menuTitleLabel.text = "총 주문금액"
        deliveryTitleLabel.text = "배달팁"
        totalTitleLabel.text = "결제예정금액"
        
        // temp
        totalPriceLabel.text = 25500.parsingToKoreanPrice()
        
        lineView.backgroundColor = .systemGray3
    }
    
    private func layout() {
        [
            menuTitleLabel, menuPriceLabel,
            deliveryTitleLabel, deliveryPriceLabel,
            lineView,
            totalTitleLabel, totalPriceLabel
        ].forEach {
            self.contentView.addSubview($0)
        }
        
        let SIDE_PADDING = 15.0
        let TOP_PADDING = 20.0
        menuTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(TOP_PADDING)
            $0.leading.equalToSuperview().offset(SIDE_PADDING)
        }
        menuPriceLabel.snp.makeConstraints {
            $0.top.equalTo(menuTitleLabel)
            $0.trailing.equalToSuperview().inset(SIDE_PADDING)
        }
        
        deliveryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(menuTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(SIDE_PADDING)
        }
        deliveryPriceLabel.snp.makeConstraints {
            $0.top.equalTo(deliveryTitleLabel)
            $0.trailing.equalToSuperview().inset(SIDE_PADDING)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(deliveryTitleLabel.snp.bottom).offset(TOP_PADDING)
            $0.leading.equalToSuperview().offset(SIDE_PADDING)
            $0.trailing.equalToSuperview().offset(SIDE_PADDING)
            $0.height.equalTo(2)
        }
        
        totalTitleLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(TOP_PADDING)
            $0.leading.equalToSuperview().offset(SIDE_PADDING)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.top.equalTo(totalTitleLabel)
            $0.trailing.equalToSuperview().inset(SIDE_PADDING)
        }
        
        
    }
}
