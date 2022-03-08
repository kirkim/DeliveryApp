//
//  BannerControlButton.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/08.
//

import UIKit

class BannerControlButton: UIButton {
    
//MARK: - BannerControlButton init
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - BannerControlButton custom function
    private func setUI() {
        self.backgroundColor = .gray.withAlphaComponent(0.7)
        self.layer.cornerRadius = 15
        self.setTitle("0 / 0", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 10)
    }
}
