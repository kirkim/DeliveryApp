//
//  TopTabBarViewCell.swift
//  CustomTabBar
//
//  Created by 김기림 on 2022/04/07.
//

import UIKit
import SnapKit

class TopBarLayoutViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.backgroundColor = .black
    }
    
    private func layout() {
    }
    
    func setData(view: UIView) {
        [view].forEach {
            self.addSubview($0)
        }
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

