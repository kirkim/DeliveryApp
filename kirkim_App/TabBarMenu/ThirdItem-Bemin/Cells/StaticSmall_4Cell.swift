//
//  Static.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import UIKit
import SnapKit

class StaticSmall_4Cell: UICollectionViewCell, StaticCellProtocol {
    static let cellId: String = "StaticSmall_4Cell"
    let titleLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .purple
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
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