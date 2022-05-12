//
//  EmptyCartView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/12.
//

import UIKit
import SnapKit

class EmptyCartView: UIView {
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.titleLabel.text = "텅"
        self.titleLabel.font = .systemFont(ofSize: 100, weight: .bold)
    }
    
    private func layout() {
        [titleLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
}
