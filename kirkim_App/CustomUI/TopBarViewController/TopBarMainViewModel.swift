//
//  TopBarViewModel.swift
//  TopBarVC
//
//  Created by 김기림 on 2022/04/07.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

struct TopBarMainViewModel {
    var startPage: Int = 0
    let topBarViewModel: TopBarViewModel
    let layoutViewModel: TopBarLayoutViewModel
    let bottomBarViewModel: BottomBarViewModel
    let subViewControllers: [UIViewController]
    
    private let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let presentVC: Signal<UIViewController>
    let dismissVC: Signal<Void>
    
    init(topBarItems: [TopBarItem], bottomBarItem: BottomBarItem) {
        let titles = topBarItems.map { $0.itemTitle }
        let viewControllers = topBarItems.map { $0.viewController }
        
        self.subViewControllers = viewControllers
        self.layoutViewModel = TopBarLayoutViewModel(views: viewControllers.map { $0.view })
        self.topBarViewModel = TopBarViewModel(itemTitles: titles)
        self.bottomBarViewModel = BottomBarViewModel(bottomBarItem: bottomBarItem)
        
        layoutViewModel.scrolledPage
            .emit(to: topBarViewModel.scrolledPage)
            .disposed(by: disposeBag)
        
        topBarViewModel.slotChanged
            .bind(to: layoutViewModel.slotChanged)
            .disposed(by: disposeBag)
        
        presentVC = bottomBarViewModel.presentVC
        dismissVC = bottomBarViewModel.dismissVC.asSignal()
    }
}
