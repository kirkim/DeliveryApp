//
//  StaticMidiumCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/10.
//

import UIKit
import SnapKit

class StaticMediumCell: UICollectionViewCell, StaticCellProtocol {
    static let cellId: String = "StaticMediumCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .green
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
}
