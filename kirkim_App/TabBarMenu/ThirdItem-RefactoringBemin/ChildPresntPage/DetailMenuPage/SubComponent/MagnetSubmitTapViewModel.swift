//
//  MagnetSubmitTapViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/02.
//

import Foundation
import RxCocoa

struct MagnetSubmitTapViewModel {
    // ParentViewModel(magnetPresentMenuViewModel) -> ViewModel -> View
    let canSubmit = BehaviorRelay<Bool>(value: false)
    let currentPrice = BehaviorRelay<Int>(value: 0)
    
    // View -> ViewModel -> ParentViewModel(magnetPresentMenuViewModel)
    let submitButtonTapped = PublishRelay<Void>()
}
