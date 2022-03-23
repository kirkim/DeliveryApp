//
//  MyBannerByPlistUsingRxSWiftViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit

struct RxBannerViewModel {
    private let manager: RxBannerViewManager
    
    init(plistType: StaticBannerPlistModel.BannerType) {
        manager = RxBannerViewManager(type: .staticEvent)
    }
    
    var buttonViewModel: RxBannerButtonViewModel {
        return manager.buttonViewModel
    }
    
    var bannerListViewModel: RxBannerListViewModel {
        return manager.bannerListViewModel
    }
}

struct RxBannerViewManager {
    let bannerListViewModel: RxBannerListViewModel
    let buttonViewModel: RxBannerButtonViewModel
    let plistModel: StaticBannerPlistModel
    
    init(type: StaticBannerPlistModel.BannerType) {
        self.plistModel = StaticBannerPlistModel(type: type)
        self.bannerListViewModel = RxBannerListViewModel(imageNames: plistModel.getAllImageName())
        self.buttonViewModel = RxBannerButtonViewModel(bannerPageSubject: bannerListViewModel.nowPage, totalPage: plistModel.getCount())
    }
}
