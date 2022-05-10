//
//  SampleHeaderCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/18.
//

import SnapKit
import UIKit
import Reusable

class MagnetMenuHeaderCell: UICollectionReusableView, Reusable {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String) {
        self.titleLabel.text = title
    }
    
    private func attribute() {
        self.backgroundColor = .white
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func layout() {
        self.addSubview(self.titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
        }
    }
}
