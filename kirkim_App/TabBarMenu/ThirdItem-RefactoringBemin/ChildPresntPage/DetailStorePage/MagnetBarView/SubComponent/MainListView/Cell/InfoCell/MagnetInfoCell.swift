//
//  MagnetInfoCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import SnapKit
import UIKit
import Reusable

class MagnetInfoCell: UICollectionViewCell, Reusable {
    private let infoView = MagnetInfoView()
    private var flag: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MagnetInfoViewModel) {
        if (flag == false) {
            flag = true
            self.infoView.bind(viewModel)
        }
    }
    
    private func attribute() {
        
    }
    
    func setData(data: InfoItem) {
        self.infoView.setData(data: data)
    }
    
    private func layout() {
        self.addSubview(infoView)
        
        infoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
