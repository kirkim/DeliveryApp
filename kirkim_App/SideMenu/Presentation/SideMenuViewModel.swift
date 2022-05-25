//
//  SideMenuViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/25.
//

import Foundation
import RxCocoa

struct SideMenuViewModel {
    private let model = SideMenuModel()
    let headerViewModel = SideMenuHeaderViewModel()
    let footerViewModel = SideMenuFooterViewModel()
    
    // ViewModel -> View
    let presentDetailProfileVC: Signal<Void>
    let logoutButtonTapped: Signal<Void>
    let copyrightButtonTapped: Signal<Void>
    
    init() {
        presentDetailProfileVC = headerViewModel.detailProfileButtonTapped.asSignal()
        logoutButtonTapped = footerViewModel.logoutButtonTapped.asSignal()
        copyrightButtonTapped = footerViewModel.copyrightButtonTapped.asSignal()
    }
    
    
    
    //MARK: - Model -> View
    func getCellsBySection(section: Int) -> [SideMenuViewInfo] {
        return model.getCellsBySection(section: section)
    }
    
    func getAllCells() -> [SideMenuViewInfo] {
        return model.getAllCells()
    }
    
    func getCellByIndexPath(indexPath: IndexPath) -> SideMenuCell {
        return model.getCellByIndexPath(indexPath: indexPath)
    }
    
    func getCellInfoByIndexPath(indexPath: IndexPath) -> SideMenuViewInfo {
        return model.getCellInfoByIndexPath(indexPath: indexPath)
    }
    
    func getSectionCount() -> Int {
        return model.getSectionCount()
    }
}
