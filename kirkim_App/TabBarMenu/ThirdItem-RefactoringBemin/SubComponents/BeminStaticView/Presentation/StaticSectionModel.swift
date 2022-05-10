//
//  StaticSectionModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/10.
//

import UIKit
import RxCocoa

struct StaticSectionModel {
    let deliveryListViewModel = DeliveryMenuViewModel()
    let itemSelected = PublishRelay<IndexPath>()
    let presentVC: Driver<UIViewController>
    
    init() {
        presentVC = itemSelected
            .map { indexPath in
                print(indexPath)
                let vc = TopBarVCWithProfile(startPage: 0)
                return vc
            }
            .asDriver(onErrorJustReturn: UIViewController())
    }

}
