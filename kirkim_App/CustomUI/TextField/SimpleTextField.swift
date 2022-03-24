//
//  MyTextField.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/15.
//

import UIKit
import SnapKit

enum TextFieldType {
    case normal
    case password
}

class NormalTextField: SimpleTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, type: .normal)
    }
}

class SecretTextField: SimpleTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, type: .password)
    }
}

class SimpleTextField: UITextField {
    convenience init(type: TextFieldType) {
        self.init(frame: CGRect.zero)
        setUI(type: type)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init?(coder: NSCoder, type: TextFieldType) {
        super.init(coder: coder)
        setUI(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(type: TextFieldType) {
        self.borderStyle = .none
        let border = UIView()
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(2)
            $0.height.equalTo(2)
        }
        border.backgroundColor = UIColor.brown
        self.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.textColor = UIColor.black
        
        switch type {
        case .normal:
            break
        case .password:
            self.isSecureTextEntry = true
        }
    }
}
