//
//  TotalBannerViewModel.swift
//  BeminBanner
//
//  Created by 김기림 on 2022/04/11.
//

import UIKit
import RxCocoa

struct TotalBannerListViewModel {
    let cellDataSource: Driver<[TotalBannerListData]>
    
    // View -> ViewModel
    let cellClicked = PublishRelay<IndexPath>()
    
    // ViewModel -> parentView
    let presentVC: Signal<UIViewController>
    
    init(data: [TotalBannerListData]) {
        cellDataSource = Driver.just(data)
        
        presentVC = cellClicked
            .map { indexPath in
                return data[indexPath.row].presentVC
            }
            .asSignal(onErrorJustReturn: UIViewController())
    }
}
