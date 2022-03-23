//
//  StaticBannerCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/10.
//

import UIKit
import SnapKit

class StaticBannerCell: UICollectionViewCell, StaticCellProtocol {
    static let cellId = "StaticBannerCell"
    var banner: UIView?
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        if let hasBanner = banner {
            contentView.addSubview(hasBanner)
            hasBanner.snp.makeConstraints {
                $0.leading.top.trailing.bottom.equalToSuperview()
            }
        }
    }
}
