//
//  CartTypeViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/11.
//

import UIKit
import RxCocoa

struct CartTypeViewModel {
    // View -> ViewModel -> ParentViewModel
    let tappedTypeLabel = PublishRelay<ShoppingCartType>()
    
    // ViewModel -> View
    let setCartType = PublishRelay<ShoppingCartType>()
    
    init() {
        
    }
}
