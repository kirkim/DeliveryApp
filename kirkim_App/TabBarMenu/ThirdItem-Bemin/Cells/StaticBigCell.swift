//
//  StaticBigCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/10.
//
import UIKit
import SnapKit

class StaticBigCell: UICollectionViewCell, StaticCellProtocol {
    static let cellId = "StaticBigCell"
//    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .black)
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
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
        
//        imageView.contentMode = .scaleToFill
//        contentView.addSubview(imageView)
//        imageView.snp.makeConstraints {
//            $0.edges.equalToSuperview() //contentView에 크기를 맞춰줘
//        }
    }
}
