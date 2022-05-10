//
//  MyBannerByPlistUsingRxSWiftViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import RxCocoa
import RxSwift

class BeminBannerViewModel {
    private let disposeBag = DisposeBag()
    let bannerListViewModel: BeminBannerListViewModel
    let buttonViewModel: BeminBannerButtonViewModel
    var totalBannerListViewModel: TotalBannerListViewModel?
    
    // View -> ViewModel
    let buttonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let presentVC = PublishRelay<UIViewController>()
    let totalPageCount: Int
    let bannerButtonType: BannerButtonType?
    
    init(data: BannerSources) {
        self.bannerButtonType = data.bannerType
        let bannerImage = data.sources.map { $0.bannerImage }
        totalPageCount = data.sources.count
        self.bannerListViewModel = BeminBannerListViewModel(bannerImage: bannerImage)
        self.buttonViewModel = BeminBannerButtonViewModel(type: data.bannerType,nowPage: bannerListViewModel.nowPage, totalPageCount: totalPageCount)
        
        if (data.bannerType == .event) {
            let totalBannerListData = data.sources.map { source -> TotalBannerListData in
                let totalViewCellImageName = source.totalViewCellImage != nil ? source.totalViewCellImage! : BeminCellImage.storedImage(name: "")
                return TotalBannerListData(cellImage: totalViewCellImageName, presentVC: source.presentVC)
            }
            self.totalBannerListViewModel = TotalBannerListViewModel(data: totalBannerListData)
        }
        
        buttonViewModel.tapped.emit { (nowPage, bannerType) in
            switch bannerType {
            case .basic:
                let vc = data.sources[nowPage].presentVC
//                parentViewController.navigationController?.pushViewController(vc, animated: true)
                self.presentVC.accept(vc)
            case .event:
                let listView = TotalBannerListView(title: data.title, subTitle: data.subTitle, cellRatio: data.totalViewCellRatio)
                listView.bind(self.totalBannerListViewModel!)
//                parentViewController.navigationController?.pushViewController(listView, animated: true)
                self.presentVC.accept(listView)
            }
        }
        .disposed(by: disposeBag)
        
        bannerListViewModel.presentVC
            .emit { indexPath in
                let vc = data.sources[indexPath.row].presentVC
//                parentViewController.present(vc, animated: true)
                self.presentVC.accept(vc)
            }
            .disposed(by: disposeBag)
    }
}
