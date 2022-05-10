//
//  TestCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/13.
//

import SnapKit
import UIKit
import Reusable

class MagnetMenuCell: UICollectionViewCell, Reusable {
    var code: String = ""
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let thumbnailView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        [descriptionLabel].forEach {
            $0.numberOfLines = 2
            $0.lineBreakMode = .byTruncatingTail
            $0.font = .systemFont(ofSize: 13, weight: .light)
            $0.textColor = .systemGray
        }
        self.backgroundColor = .white
    }
    
    func setData(data: MenuItem, image: UIImage) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
        self.priceLabel.text = data.price.parsingToKoreanPrice()
        self.code = data.menuCode

        self.thumbnailView.image = image
    }
    
    private func layout() {
        [titleLabel, descriptionLabel, priceLabel, thumbnailView].forEach {
            self.addSubview($0)
        }
        let topMargin:CGFloat = 15
        let leftMargin:CGFloat = 20
        
        thumbnailView.snp.makeConstraints {
            $0.top.equalTo(self.contentView).offset(topMargin)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.contentView).inset(topMargin)
            $0.width.equalTo(self.contentView.frame.height - topMargin*2)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.contentView).offset(topMargin)
            $0.leading.equalTo(self.contentView).offset(leftMargin)
            $0.trailing.equalTo(thumbnailView.snp.leading)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.contentView).offset(leftMargin)
            $0.trailing.equalTo(thumbnailView.snp.leading)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.contentView).offset(leftMargin)
            $0.trailing.equalTo(thumbnailView.snp.leading).offset(-15)
        }
    }
}
