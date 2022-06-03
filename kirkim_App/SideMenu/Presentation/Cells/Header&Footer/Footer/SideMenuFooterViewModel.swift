//
//  SideMenuFooterViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/25.
//

import Foundation
import RxCocoa

struct SideMenuFooterViewModel {
    let logoutButtonTapped = PublishRelay<Void>()
    let copyrightButtonTapped = PublishRelay<Void>()
}
