//
//  InfoCollectionCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import Foundation
import UIKit
import SnapKit
import Reusable

class MagnetInfoReviewCell: UICollectionViewCell, Reusable {
    private let thumbnailView = UIImageView()
    private let reviewLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.reviewLabel.numberOfLines = 2
        self.reviewLabel.lineBreakMode = .byTruncatingTail
        self.reviewLabel.font = .systemFont(ofSize: 14)
        
        self.ratingLabel.textColor = .systemYellow
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func setData(data: SummaryReviewData, image: UIImage) {
        self.reviewLabel.text = data.review
        self.ratingLabel.text = setStar(rating: data.rating)
        
        let parsedImage = resizeImage(image: image, height: self.contentView.frame.height)
        self.thumbnailView.image = parsedImage
    }
    
    private func setStar(rating: Int = 5) -> String {
        let totalRating:String = {
            switch rating {
            case 0:
                return "☆☆☆☆☆"
            case 1:
                return "★☆☆☆☆"
            case 2:
                return "★★☆☆☆"
            case 3:
                return "★★★☆☆"
            case 4:
                return "★★★★☆"
            case 5:
                return "★★★★★"
            default:
                return "☆☆☆☆☆"
            }
        }()
        return totalRating
    }
    
    func resizeImage(image: UIImage, height: CGFloat) -> UIImage {
        let scale = height / image.size.height
        let width = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    private func layout() {
        [thumbnailView, reviewLabel, ratingLabel].forEach {
            self.addSubview($0)
        }
        let margin:CGFloat = 10
        thumbnailView.snp.makeConstraints {
            $0.leading.equalTo(self.contentView).offset(margin)
            $0.top.equalTo(self.contentView).offset(margin)
            $0.bottom.equalTo(self.contentView).inset(margin)
            $0.width.equalTo(self.contentView.frame.height - margin*2)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailView)
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(thumbnailView.snp.trailing).offset(10)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewLabel)
//            $0.top.equalTo(reviewLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
