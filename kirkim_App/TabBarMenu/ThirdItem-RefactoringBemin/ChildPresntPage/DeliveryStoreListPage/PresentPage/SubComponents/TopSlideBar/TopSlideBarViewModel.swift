//
//  TopSlideBarViewModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import Foundation
import RxCocoa
import RxSwift

struct TopSlideBarViewModel {
    private let disposeBag = DisposeBag()
    let cellData: [StoreType]
    
    // View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    
    // ViewModel -> View & ContainerStoreListViewModel
    let slotChanged = PublishRelay<Int>()
    
    // ContainerStoreListViewModel -> view
    let scrollPaged = PublishRelay<Int>()
    
    init() {
        cellData = StoreType.allCases
        itemSelected.bind(to: slotChanged).disposed(by: disposeBag)
        scrollPaged.bind(to: slotChanged).disposed(by: disposeBag)
    }
}
