//
//  SortSlideCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/07.
//

import UIKit
import SnapKit

class SortSlideCell: UICollectionViewCell {
    let titleLabel = SortSlidePaddingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.titleLabel.textColor = .systemGray4
        self.backgroundColor = .clear
    }
    
    func isValid(_ isValid: Bool) {
        if (isValid) {
            self.backgroundColor = .brown.withAlphaComponent(0.2)
            self.titleLabel.textColor = .brown
        } else {
            self.backgroundColor = .clear
            self.titleLabel.textColor = .systemGray2
        }
    }
    
    private func attribute() {
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        self.titleLabel.textColor = .systemGray2
        self.layer.cornerRadius = self.frame.height/2
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

class SortSlidePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: 5.0)

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
