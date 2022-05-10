//
//  PopupLabel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/02.
//

import UIKit

class PopupLabel: UILabel {
    private var padding = UIEdgeInsets(top: 10.0, left: 16.0, bottom: 10.0, right: 16.0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.backgroundColor = .black
        self.textColor = .white
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
