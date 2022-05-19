//
//  MagnetBannerCellViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/18.
//

import UIKit
import RxCocoa
import RxSwift

struct MagnetBannerCellViewModel {
    let mainHeaderViewModel = MagnetHeaderViewModel()
    private let disposeBag = DisposeBag()
    
    // ParentView -> ViewModel
    let movingHeaderView = PublishRelay<(CGFloat, CGFloat)>()
    
    init() {
        movingHeaderView
            .bind(to: mainHeaderViewModel.scrolled)
            .disposed(by: disposeBag)
    }
}
