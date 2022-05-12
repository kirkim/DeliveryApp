//
//  CartTypePopupViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/11.
//

import Foundation
import RxSwift
import RxCocoa

struct CartTypePopupViewModel {
    let selectedCartType = PublishRelay<ShoppingCartType>()
}
