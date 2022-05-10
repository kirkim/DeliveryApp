//
//  MagnetPresentMenuCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/01.
//

import UIKit
import SnapKit
import Reusable

class MagnetPresentMenuCell: UICollectionViewCell, Reusable {
    private let checkBoxImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private var price: Int = 0
    var isClicked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.isClicked = false
        self.checkBoxImageView.image = UIImage(systemName: "circle")
    }
    
    func setData(data: PresentMenuItem) {
        self.titleLabel.text = data.title
        self.price = data.price ?? 0
        self.priceLabel.text = (data.price ?? 0).parsingToKoreanPrice()
    }
    
    func clickedItem() -> Int {
        isClicked.toggle()
        if (isClicked == true) {
            self.checkBoxImageView.image = UIImage(systemName: "circle.circle")
            return self.price
        } else {
            self.checkBoxImageView.image = UIImage(systemName: "circle")
            return -self.price
        }
    }
    
    private func attribute() {
        self.backgroundColor = .white
        //Temp
        self.checkBoxImageView.image = UIImage(systemName: "circle")
    }
    
    private func layout() {
        [checkBoxImageView, titleLabel, priceLabel].forEach {
            self.addSubview($0)
        }
        
        checkBoxImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(checkBoxImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
