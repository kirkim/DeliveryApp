//
//  ShoppingcartViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/12.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingcartViewModel {
    let cartTableViewModel = CartTableViewModel()
    let cartTypePopupViewModel = CartTypePopupViewModel()
    
    private let disposeBag = DisposeBag()
    private let cartManager = CartManager.shared
    
    // ViewModel -> View
    let popupCartTypeView:Signal<ShoppingCartType>
    
    init() {
        popupCartTypeView = cartTableViewModel.tappedTypeLabel
        
        cartTypePopupViewModel.selectedCartType
            .bind{ type in
                self.cartManager.changeType(data: type)
            }
            .disposed(by: disposeBag)
    }
}
