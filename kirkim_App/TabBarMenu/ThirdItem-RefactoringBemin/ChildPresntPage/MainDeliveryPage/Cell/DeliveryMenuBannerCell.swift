//
//  DeliveryMenuBannerCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import UIKit
import Reusable

class DeliveryMenuBannerCell: UICollectionViewCell, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBanner(banner: BeminBannerView) {
        self.contentView.addSubview(banner)
        banner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let width = 100.0
        let height = 30.0
        let x = self.contentView.frame.width - width - 10.0
        let y = self.contentView.frame.height - height - 10.0
        banner.setButtonFrame(frame: CGRect(x: x, y: y, width: width, height: height))
    }
}
