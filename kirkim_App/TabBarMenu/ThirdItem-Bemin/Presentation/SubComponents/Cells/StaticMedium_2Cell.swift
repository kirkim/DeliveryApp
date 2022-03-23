//
//  File.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import UIKit
import SnapKit

class StaticMedium_2Cell: UICollectionViewCell, StaticCellProtocol {
    static let cellId: String = "StaticMedium_2Cell"
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let descriptionLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .yellow
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .black)
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.top.equalToSuperview().offset(5)
        }
        
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(imageView.snp.height)
        }
        
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .medium)
        descriptionLabel.textColor = .purple
        descriptionLabel.numberOfLines = 2
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-50)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }

    }
}
