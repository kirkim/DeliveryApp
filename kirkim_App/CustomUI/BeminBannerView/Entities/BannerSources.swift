//
//  BannerSources.swift
//  BeminBanner
//
//  Created by 김기림 on 2022/04/11.
//

import UIKit

enum BeminCellImage {
    case urlImage(url: String)
    case storedImage(name: String)
}

struct BannerSource {
    let bannerImage: BeminCellImage
    var totalViewCellImage: BeminCellImage?
    let presentVC: UIViewController
}

struct BannerSources {
    let bannerType: BannerButtonType
    var title: String = ""
    var subTitle: String = ""
    var totalViewCellRatio: CGFloat = 0
    let sources: [BannerSource]
}

struct TotalBannerListData {
    let cellImage: BeminCellImage
    let presentVC: UIViewController
}
