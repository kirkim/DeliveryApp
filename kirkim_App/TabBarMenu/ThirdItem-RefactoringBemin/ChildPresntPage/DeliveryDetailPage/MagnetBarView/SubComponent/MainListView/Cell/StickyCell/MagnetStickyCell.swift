//
//  StickyHeaderCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/19.
//

import SnapKit
import UIKit
import Reusable

class MagnetStickyCell: UICollectionViewCell, Reusable {
    private let stickyHeaderView = RemoteMainListBar()
    private var flag: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: RemoteMainListBarViewModel) {
        if (flag == false) {
            flag = true
            self.stickyHeaderView.bind(viewModel)
        }
    }
    
    private func attribute() {
    }
    
    private func layout() {
        self.addSubview(self.stickyHeaderView)
        
        stickyHeaderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
