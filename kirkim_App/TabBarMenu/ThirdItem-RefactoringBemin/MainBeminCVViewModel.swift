//
//  MainBeminCVViewModel.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import UIKit
import RxSwift
import RxCocoa

struct MainBeminViewModel {
    let staticSectionViewModel = StaticSectionViewModel()
    //ViewModel -> View
    let cellData: Driver<[String]>
    
    //View -> ViewModel
    
    init() {
        cellData = Observable
            .just(["staticView"])
            .asDriver(onErrorJustReturn: [])
    }
}
