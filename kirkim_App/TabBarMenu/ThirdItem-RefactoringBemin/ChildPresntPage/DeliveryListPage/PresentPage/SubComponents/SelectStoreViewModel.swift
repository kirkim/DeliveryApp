//
//  DeliveryListViewModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import Foundation
import RxSwift
import RxCocoa

struct SelectStoreViewModel {
    let topSlideBarViewModel = TopSlideBarViewModel()
    let sortSlideBarViewModel = SortSlideBarViewModel()
    let containerListViewModel = ContainerStoreListViewModel()
    private let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let changeTitle = PublishRelay<String>()
    let presentStoreDetailVC: Signal<String>
    
    init() {
        let slotChanged = topSlideBarViewModel.slotChanged.share()
        slotChanged
            .map { StoreType.allCases[$0].title }
            .bind(to: changeTitle)
            .disposed(by: disposeBag)
        
        slotChanged
            .bind(to: containerListViewModel.slotChanged)
            .disposed(by: disposeBag)
        
        containerListViewModel.scrollPaged
            .bind(to: topSlideBarViewModel.scrollPaged)
            .disposed(by: disposeBag)
        
        presentStoreDetailVC = containerListViewModel.presentStoreDetailVC
    }
}
