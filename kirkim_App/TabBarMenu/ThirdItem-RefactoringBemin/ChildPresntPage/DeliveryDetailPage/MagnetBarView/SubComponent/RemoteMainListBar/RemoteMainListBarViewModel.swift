//
//  RemoteMainListBarViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/19.
//

import UIKit
import RxCocoa
import RxSwift

struct RemoteMainListBarViewModel {
    let data: [String]
    
    private let disposeBag = DisposeBag()
    
    // TopBarLayoutView -> ViewModel
    let scrolledPage = PublishRelay<IndexPath>()
    
    // View -> ViewModel -> listView
    let slotChanged = PublishRelay<IndexPath>()
    
    //ViewModel -> View
    let slotChanging = PublishRelay<IndexPath>()
    
    init(itemTitles: [String]) {
        self.data = itemTitles
        
        scrolledPage
            .bind(to: slotChanging)
            .disposed(by: disposeBag)
    }
}
