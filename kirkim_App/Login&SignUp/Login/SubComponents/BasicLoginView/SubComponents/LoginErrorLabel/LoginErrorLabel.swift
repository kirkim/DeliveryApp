//
//  LoginErrorLabel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import UIKit

class LoginErrorLabel: UILabel {
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
