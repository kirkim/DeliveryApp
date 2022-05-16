//
//  File.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import Foundation
import RxDataSources
import RxCocoa

struct StoreListViewModel {
    // ViewModel -> ParentViewModel
    let presentStoreDetailVC = PublishRelay<String>()
    
    init() {

    }
}
