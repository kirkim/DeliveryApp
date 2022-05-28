//
//  MyLikeStoresViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/28.
//

import Foundation
import RxDataSources
import RxCocoa

struct MyLikeStoresListViewModel {
    private let model = MyLikeStoresListModel()
    // ViewModel -> ParentViewModel
    let presentStoreDetailVC = PublishRelay<String>()
    
    init() {
        
    }
    
    func getDataSource() -> RxCollectionViewSectionedReloadDataSource<StoreListSection> {
        return model.dataSource()
    }
    
    func getCellData() -> Driver<[StoreListSection]> {
        return model.getCellData().asDriver(onErrorJustReturn: [])
    }
    
    func update(completion: (() -> ())? = nil) {
        model.updateData(completion: completion)
    }
}
