//
//  NormalTextField.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/31.
//

import UIKit

class NormalTextField: SimpleTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, type: .normal)
    }
}
