//
//  BottomBarViewModel.swift
//  TopBarVC
//
//  Created by 김기림 on 2022/04/08.
//

import RxCocoa
import RxSwift
import UIKit

struct BottomBarViewModel {
    let bundleBaseButtonViewModel: BundleBaseButtonViewModel
    private let disposeBag = DisposeBag()
    // View -> ViewModel
    let buttonTapped = PublishRelay<ButtonType>()
    let centerButtonTapped = PublishRelay<Void>()
    
    // ViewModel -> View
    let presentVC: Signal<UIViewController>
    let dismissVC: Signal<Void>
    
    init(bottomBarItem: BottomBarItem) {
        bundleBaseButtonViewModel = BundleBaseButtonViewModel(bottomBarItem: bottomBarItem)
        presentVC = bundleBaseButtonViewModel.presentVC.asSignal()
        dismissVC = centerButtonTapped.asSignal()
    }
}
