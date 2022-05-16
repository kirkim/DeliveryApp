//
//  DeliveryMenuBasicCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import UIKit
import SnapKit
import Reusable

class DeliveryMenuBasicCell: UICollectionViewCell, Reusable {
    private let titleLabel = UILabel()
    private let thumbnailImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: BasicMenuItem) {
        self.titleLabel.text = data.menuType.title
        self.thumbnailImageView.image = UIImage(named: data.logoImage)
    }
    
    private func attribute() {
//        self.backgroundColor = .
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        // temp
        self.thumbnailImageView.backgroundColor = .blue
    }
    
    private func layout() {
        [thumbnailImageView, titleLabel].forEach {
            self.addSubview($0)
        }
        
        self.thumbnailImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(self.thumbnailImageView.snp.width)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.centerX.equalToSuperview()
        }
    }
}
