//
//  MagnetSubmitTapViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/02.
//

import Foundation
import RxCocoa

struct MagnetSubmitTapViewModel {
    let canSubmit = BehaviorRelay<Bool>(value: false)
    let currentPrice = BehaviorRelay<Int>(value: 0)
}
