//
//  TotalBannerListCell.swift
//  BeminBanner
//
//  Created by 김기림 on 2022/04/11.
//

import UIKit
import SnapKit

class TotalBannerListCell: UICollectionViewCell {
    private let thumbNail = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 16, right: 16))
    }

    private func attribute() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
    
    private func layout() {
        [thumbNail].forEach {
            self.addSubview($0)
        }
        
        thumbNail.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setData(imageData: BeminCellImage) {
        switch imageData {
        case .storedImage(name: let name):
            self.setImageName(imageName: name)
        case .urlImage(url: let url):
            self.setImageUrl(imageUrl: url)
        }
    }
    
    private func setImageName(imageName: String) {
        let image = UIImage(named: imageName)
        self.thumbNail.image = image
    }
    
    private func setImageUrl(imageUrl: String) {
        DispatchQueue.global().async {
            let url = URL(string: imageUrl)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                self.thumbNail.image = image
            }
        }
    }

}
