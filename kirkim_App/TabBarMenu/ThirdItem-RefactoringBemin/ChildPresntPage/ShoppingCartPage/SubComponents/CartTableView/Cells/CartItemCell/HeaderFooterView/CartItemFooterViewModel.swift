//
//  CartItemFooterViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/16.
//

import UIKit
import RxCocoa

struct CartItemFooterViewModel {
    
    //View -> ViewModel -> ParentViewModel
    let buttonTapped = PublishRelay<UITapGestureRecognizer>()
}
