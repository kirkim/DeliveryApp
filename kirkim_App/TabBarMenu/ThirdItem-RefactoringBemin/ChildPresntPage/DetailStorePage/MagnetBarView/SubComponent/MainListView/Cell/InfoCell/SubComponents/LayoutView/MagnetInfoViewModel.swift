//
//  MagnetInfoViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import Foundation
import RxCocoa

struct MagnetInfoViewModel {
    let infoCollectionViewModel = MagnetSummaryReviewViewModel()
    let navViewModel = MagnetInfoNavBarViewModel()
    
    //ChildViewModel -> ViewModel -> ParentViewModel
    let popVC: Signal<Int?>
    
    init() {
        popVC = infoCollectionViewModel.popVC
    }
}
