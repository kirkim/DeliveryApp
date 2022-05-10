//
//  DeliveryMenuBannerCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import UIKit
import Reusable

class DeliveryMenuBannerCell: UICollectionViewCell, Reusable {
    var bannerView: BeminBannerView?
    private var flag: Bool = false
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: BannerSources) {
        if (flag == false) {
            self.flag = true
            let hasBannerView = BeminBannerView(data: data)
            self.bannerView = hasBannerView
            self.addSubview(hasBannerView)
            hasBannerView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            let btnWidth = 100.0
            let btnHeight = 30.0
            let x = 300.0
            let y = 100.0
            hasBannerView.setButtonFrame(frame: CGRect(x: x, y: y, width: btnWidth, height: btnHeight))
        }
        
    }
}
