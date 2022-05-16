//
//  ShoppingcartViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/12.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingcartViewModel {
    let cartTableViewModel = CartTableViewModel()
    let cartTypePopupViewModel = CartTypePopupViewModel()
    
    private let disposeBag = DisposeBag()
    private let cartManager = CartManager.shared
    
    // ViewModel -> View
    let popupCartTypeView:Signal<ShoppingCartType>
    let presentStoreVC = PublishRelay<String>()
    let presentDetailMenuVC:Signal<PresentDetailMenuPoint>
    
    init() {
        popupCartTypeView = cartTableViewModel.tappedTypeLabel
        presentDetailMenuVC = cartManager.presentItemVC.asSignal()
        cartManager.presentStoreVC
            .map { _ in self.cartManager.getStoreCode() }
            .bind(to: presentStoreVC)
            .disposed(by: disposeBag)
        
        cartTypePopupViewModel.selectedCartType
            .bind{ type in
                self.cartManager.changeType(data: type)
            }
            .disposed(by: disposeBag)
        
        
    }
}
