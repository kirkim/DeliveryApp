//
//  BannerCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/14.
//

import SnapKit
import UIKit
import Reusable

class MagnetBannerCell: UICollectionViewCell, Reusable {
    private let httpManager = HttpModel.shared
    private let banner: BeminBannerView
    private let headerView = MagnetHeaderView()
    private var flag: Bool = false
    
    override init(frame: CGRect) {
        var bannerSources:[BannerSource] = []
        httpManager.getBannerImageUrls().forEach { imageUrl in
            bannerSources.append(BannerSource(bannerImage: BeminCellImage.urlImage(url: imageUrl), presentVC: UIViewController()))
        }
        self.banner = BeminBannerView(
            data: BannerSources(
                bannerType: .basic,
                sources: bannerSources
            )
        )
        super.init(frame: frame)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.backgroundColor = .white
    }
    
    func setData(title: String) {
        self.headerView.setTitle(title: title)
    }
    
    func bind(_ viewModel: MagnetBannerCellViewModel) {
        if (flag == false) {
            flag = true
            self.headerView.bind(viewModel.mainHeaderViewModel)
        }
    }
    
    func layout() {
        [banner, headerView].forEach {
            self.addSubview($0)
        }
        
        banner.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(MagnetBarViewMath.windowWidth*8/13)
        }
        let windowWidth = MagnetBarViewMath.windowWidth
        let buttonWidth = 60.0
        let buttonheight = 20.0
        banner.setButtonFrame(frame: CGRect(x: windowWidth-buttonWidth-20 , y: windowWidth*(8/13)-120, width: buttonWidth, height: buttonheight))
        
        headerView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-4)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(MagnetBarViewMath.headerViewHeight)
        }
        
        headerView.layout()
    }
}
