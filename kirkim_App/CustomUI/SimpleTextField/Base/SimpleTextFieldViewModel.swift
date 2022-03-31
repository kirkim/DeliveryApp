//
//  SimpleTextFieldViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/31.
//

import Foundation
import RxCocoa
import RxSwift

struct SimpleTextFieldViewModel {
    private let disposeBag = DisposeBag()
    
    //View -> ViewModel
    let text = PublishRelay<String>()
    
    //ViewModel -> View
    let isEditable: Signal<Bool>
    
    init(maxLength: Int) {
        isEditable = text
            .map { $0.count <= maxLength }
            .asSignal(onErrorJustReturn: true)
    }
}
