//
//  SubmitCheckAlertViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/18.
//

import UIKit
import RxCocoa

struct SubmitCheckAlertViewModel {
    
    // View -> ViewModel -> ParentViewModel
    let cancelButtonTapped = PublishRelay<UITapGestureRecognizer>()
    let okButtonTapped = PublishRelay<UITapGestureRecognizer>()
}
