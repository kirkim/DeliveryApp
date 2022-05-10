//
//  MagnetInfoMoreButtonCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import Foundation
import UIKit
import SnapKit
import Reusable

class MagnetInfoMoreButtonCell: UICollectionViewCell, Reusable {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.titleLabel.text = "포토 리뷰 더보기 〉"
        self.titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        self.titleLabel.numberOfLines = 2
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    private func layout() {
        self.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(13)
            $0.centerY.equalToSuperview()
        }
    }
}
