//
//  DeliveryInfo.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import UIKit

class DelieveryInfoView: UIView {
    private let deliveryPriceLabel = UILabel()
    private let minPriceLabel = UILabel()
    private let section1 = UILabel()
    private let section2 = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(deliveryPrice: Int, minPrice: Int) {
        deliveryPriceLabel.text = deliveryPrice.parsingToKoreanPrice()
        minPriceLabel.text = minPrice.parsingToKoreanPrice()
    }
    
    private func attribute() {
        self.section1.text = "배달비"
        self.section2.text = "최소주문"
        
        [section1, section2, deliveryPriceLabel, minPriceLabel].forEach {
            $0.font = .systemFont(ofSize: 16, weight: .light)
            $0.textColor = .black
        }
    }
    
    private func layout() {
        [section1, section2, deliveryPriceLabel, minPriceLabel].forEach {
            self.addSubview($0)
        }
        
        let sectionWidth:CGFloat = 100
        
        section1.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(sectionWidth)
        }
        
        section2.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(section1.snp.bottom).offset(10)
            $0.width.equalTo(sectionWidth)
        }
        
        deliveryPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(section1.snp.trailing)
            $0.top.equalTo(section1)
        }
        
        minPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(section2.snp.trailing)
            $0.top.equalTo(section2)
        }
    }
}
