//
//  BannerCell.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/08.
//

import UIKit
import SnapKit

class MyBannerCell: UICollectionViewCell {
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(self.imageView)
        self.imageView.contentMode = .scaleToFill
        self.imageView.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview()
        }
    }
    
    func setData(image: UIImage?) {
        guard let image = image else { return }
        self.imageView.image = image
    }
}
