//
//  SignUpErrorLabel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/30.
//

import UIKit

class SignUpErrorLabel: UILabel {
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.textColor = .systemRed
        self.font = .systemFont(ofSize: 13, weight: .light)
    }
}
