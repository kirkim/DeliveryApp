//
//  File.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/28.
//

import Foundation
import RxCocoa

struct MyLikeStoresPageViewModel {
    let collectionViewModel = MyLikeStoresListViewModel()
    
    // ViewModel -> View
    let presentStoreDetailVC: Signal<String>
    
    init() {
        presentStoreDetailVC = collectionViewModel.presentStoreDetailVC.asSignal()
    }
}
