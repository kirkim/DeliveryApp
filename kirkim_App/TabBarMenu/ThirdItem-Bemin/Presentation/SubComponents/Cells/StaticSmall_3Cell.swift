//
//  StaticSmallCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/10.
//

import UIKit
import SnapKit

class StaticSmall_3Cell: UICollectionViewCell, StaticCellProtocol {
    static let cellId: String = "StaticSmall_3Cell"
    let titleLabel = UILabel()
    let imageView = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .black)
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
}
