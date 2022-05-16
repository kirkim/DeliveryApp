//
//  DeliveryMenuSpecialCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import UIKit
import SnapKit
import Reusable

class DeliveryMenuSpecialCell: UICollectionViewCell, Reusable {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: SpecialMenuItem) {
        self.titleLabel.text = data.title
    }
    
    private func attribute() {
        self.backgroundColor = .brown
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textColor = .white
        self.layer.cornerRadius = 10
    }
    
    private func layout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(30)
        }
    }
}
