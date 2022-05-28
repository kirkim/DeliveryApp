//
//  BottomButtonView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/27.
//

import UIKit
import SnapKit

class BottomButtonView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public function
    func setData(data: BottomButtonData) {
        self.imageView.image = data.image
        self.titleLabel.text = data.title
        self.titleLabel.textColor = data.tintColor
        self.imageView.tintColor = data.tintColor
        self.backgroundColor = data.backgroundColor
    }
    
    //MARK: - Private function
    private func attribute() {
        self.titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
    }
    
    private func layout() {
        [imageView, titleLabel].forEach {
            self.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom)
        }
    }
}
