//
//  TopSlideCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import UIKit
import SnapKit

class TopSlideCell: UICollectionViewCell {
    private let titleLabel = TopSlidePaddingLabel()
    private let underline = UIView()
    
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
        self.underline.backgroundColor = .clear
    }
    
    private func attribute() {
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .systemGray2
        self.layer.cornerRadius = self.frame.height/2
        self.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        self.underline.backgroundColor = .clear
    }
    
    func isValid(_ isValid: Bool) {
        if (isValid) {
            self.titleLabel.textColor = .black
            self.underline.backgroundColor = .black
        } else {
            self.titleLabel.textColor = .systemGray2
            self.underline.backgroundColor = .clear
        }
    }
    
    private func layout() {
        [titleLabel, underline].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        underline.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    func setData(title: String) {
        self.titleLabel.text = title
    }
}

class TopSlidePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

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
