//
//  MagnetInfoNavBar.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import Foundation
import RxCocoa

struct MagnetInfoNavBarViewModel {
    // View -> ViewModel
    let tappedButton = PublishRelay<MagnetInfoType>()
    
    // ViewModel -> ParentViewModel
    let buttonChanged: Signal<MagnetInfoType>
    
    init() {
        buttonChanged = tappedButton
            .distinctUntilChanged()
            .asSignal(onErrorJustReturn: .delivery)
    }
}

