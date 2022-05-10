//
//  StoreListCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import UIKit
import SnapKit
import Reusable

class StoreListCell: UICollectionViewCell, Reusable {
    private var storeCode: String?
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    
    private let starLabel = UILabel()
    private let averageRatingLabel = UILabel()
    private let reviewCountLabel = UILabel()
    
    private let menuLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.menuLabel.textColor = .systemGray
        self.priceLabel.textColor = .systemGray
        
        self.titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        self.averageRatingLabel.font = .systemFont(ofSize: 15, weight: .medium)
        [reviewCountLabel, starLabel, menuLabel, priceLabel].forEach {
            $0.font = .systemFont(ofSize: 15)
        }
    }
    
    func setData(data: SummaryStoreItem) {
        self.storeCode = data.storeCode
        self.thumbnailImageView.image = UIImage(systemName: "circle")
        self.titleLabel.text = data.storeName
        
        self.starLabel.text = "★"
        self.starLabel.textColor = .systemYellow
        self.averageRatingLabel.text = "\(floor(data.averageRating*100)/100)"
        
        self.reviewCountLabel.text = parsingReviewCount(data.reviewCount)
        self.menuLabel.text = data.twoMainMenuName[0] + ", " + data.twoMainMenuName[1]
        
        self.priceLabel.text = "최소주문 " + data.minPrice.parsingToKoreanPrice() + ",배달팁 " + data.deliveryPrice.parsingToKoreanPrice()
    }
 
    private func parsingReviewCount(_ count: Int) -> String {
        if (count < 10) {
            return "(\(count))"
        } else if (count < 100) {
            return "(\(count - count%10)+)"
        } else {
            return "(\(count - count%100)+"
        }
    }
    
    private func layout() {
        [thumbnailImageView, titleLabel,
         starLabel, averageRatingLabel, reviewCountLabel,
         menuLabel, priceLabel].forEach {
            self.addSubview($0)
        }
        
        let padding = 10.0
        let spaceByThumbnail = 10.0
        let lineSpace = 8.0
        
        thumbnailImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(padding)
            $0.width.height.equalTo(self.frame.width/5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(spaceByThumbnail)
            $0.trailing.equalToSuperview().inset(padding)
            $0.top.equalTo(thumbnailImageView)
        }
        
        starLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(lineSpace)
        }

        averageRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(starLabel.snp.trailing).offset(1)
            $0.top.equalTo(starLabel)
        }
        reviewCountLabel.snp.makeConstraints {
            $0.leading.equalTo(averageRatingLabel.snp.trailing)
            $0.top.equalTo(starLabel)
        }
        menuLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewCountLabel.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(padding)
            $0.top.equalTo(starLabel)
        }
        
        menuLabel.setContentHuggingPriority(.init(rawValue: 1), for: .horizontal) // 우선순위 낮게
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(starLabel.snp.bottom).offset(lineSpace)
            $0.trailing.equalToSuperview().inset(padding)
        }
    }
}
