//
//  MagnetReviewCellViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/24.
//

import Foundation
import RxCocoa

struct MagnetReviewCellViewModel {
    
    // View -> ViewModel -> ParentViewModel
    let nameLabelTapped = PublishRelay<UserInfo>()
}
