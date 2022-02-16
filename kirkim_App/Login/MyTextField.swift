//
//  MyTextField.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/15.
//

import UIKit

class MyTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        self.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.width, height: 1)
        border.backgroundColor = UIColor.brown.cgColor
        self.layer.addSublayer(border)
        self.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.textColor = UIColor.black
    }
}
