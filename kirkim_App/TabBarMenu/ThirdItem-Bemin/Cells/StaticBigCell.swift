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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        
//        imageView.contentMode = .scaleToFill
//        contentView.addSubview(imageView)
//        imageView.snp.makeConstraints {
//            $0.edges.equalToSuperview() //contentView에 크기를 맞춰줘
//        }
    }
}
