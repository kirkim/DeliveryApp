//
//  StaticSmallCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/10.
//

import UIKit
import SnapKit

class StaticSmallCell: UICollectionViewCell, StaticCellProtocol {
    static let cellId: String = "StaticSmallCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
}
