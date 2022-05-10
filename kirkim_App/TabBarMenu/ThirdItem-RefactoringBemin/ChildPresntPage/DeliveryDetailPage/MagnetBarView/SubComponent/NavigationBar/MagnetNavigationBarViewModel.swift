//
//  MagnetNavigationBarViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/14.
//

import UIKit
import RxCocoa

struct MagnetNavigationBarViewModel {
    // ParentView -> ViewModel
    let scrolled = PublishRelay<(CGFloat, CGFloat)>()
    
    // ViewModel -> View
    let transItem: Signal<(CGFloat, CGFloat)>
    let backButtonTapped = PublishRelay<Void>()
    
    let mainTitle:String
    
    init() {
        self.mainTitle = HttpModel.shared.getStoreName()
        transItem = scrolled.asSignal()
    }
}
