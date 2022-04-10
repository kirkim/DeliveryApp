//
//  StaticSectionModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/10.
//

import UIKit
import RxCocoa

struct StaticSectionModel {
    private let viewModel: TopBarMainViewModel
    let itemSelected = PublishRelay<IndexPath>()
    let presentVC: Driver<UIViewController>
    
    init() {
        let viewModel = TopBarMainViewModel(
            topBarItems: [
                TopBarItem(viewController: Test1(), itemTitle: "배민1"),
                TopBarItem(viewController: Test2(), itemTitle: "배달"),
                TopBarItem(viewController: Test3(), itemTitle: "포장"),
                TopBarItem(viewController: Test1(), itemTitle: "B마트"),
                TopBarItem(viewController: Test2(), itemTitle: "배민스토어"),
                TopBarItem(viewController: Test3(), itemTitle: "쇼핑라이브"),
                TopBarItem(viewController: Test1(), itemTitle: "선물하기"),
                TopBarItem(viewController: Test2(), itemTitle: "전국별미"),
            ],
            bottomBarItem: BottomBarItem(
                presentVC1: ButtonVC1(),
                presentVC2: ButtonVC2(),
                presentVC3: ButtonVC3(),
                presentVC4: ButtonVC4()
            )
        )
        self.viewModel = viewModel
        presentVC = itemSelected
            .map { indexPath in
                print(indexPath)
                let vc = TopBarMainViewController(startPage: 0)
                vc.bind(viewModel)
                return vc
            }
            .asDriver(onErrorJustReturn: UIViewController())
    }

}
