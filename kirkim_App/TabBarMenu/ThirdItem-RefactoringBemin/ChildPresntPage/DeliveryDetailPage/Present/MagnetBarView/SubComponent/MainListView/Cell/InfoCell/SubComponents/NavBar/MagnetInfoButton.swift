//
//  InfoButtonStyle.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import UIKit
import SnapKit

class MagnetInfoButton: UIView {
    private let titleLabel = UILabel()
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        titleLabel.text = title
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.titleLabel.font = .systemFont(ofSize: 17)
        self.titleLabel.textColor = .black
    }
    
    private func layout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func selected() {
        self.titleLabel.textColor = .systemBlue
    }
    
    func deSelected() {
        self.titleLabel.textColor = .black
    }
}
