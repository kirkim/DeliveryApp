//
//  RemoteMainListBarCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/19.
//

import UIKit
import SnapKit

class RemoteMainListBarCell: UICollectionViewCell {
    let titleLabel = BasePaddingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .black
    }
    
    private func layout() {
        [titleLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setData(title: String) {
        self.titleLabel.text = title
    }
}

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 16.0, left: 10.0, bottom: 16.0, right: 10.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
