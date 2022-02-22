//
//  SideBarMenuModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
// 주기능: 1. SideMenuCellModel가 사이드매뉴의 뷰컨트롤러들을 가지고 있음 (SideMenuCellInfo구조체 형태로)
//       2. 저장된 뷰컨트롤러와 메인테이블뷰(SideMenuVC) 사이에 징검다리 역할을 해준다 (단, viewcontroller는 SideMenuCellView프로토콜을 준수해야함)
// how?: Viewcontroller들을 커스텀셀(SideMenuCell) 혹은 SideMenuCellInfo구조체 형태로 파싱하여 보내준다.
//

import UIKit

enum SideMenuSection: Int {
    case one
    case two
    case three
    static var count: Int {
        return 3
    }
}

protocol SideMenuCellView {
    static var sideMenuCellInfo: SideMenuCellInfo { get }
}

struct SideMenuCellInfo {
    var thumnailImage: UIImage?
    var mainTitle: String?
    var section: SideMenuSection?
    var identifier: String?
}

struct SideMenuCellModel {
    private let manager = SideMenuCellManager.shared
    
    func getCellsBySection(section: Int) -> [SideMenuCellInfo] {
        return manager.getCellsBySection(section: section)
    }
    
    func getAllCells() -> [SideMenuCellInfo] {
        return manager.getAllCells()
    }
    
    func getCellByIndexPath(indexPath: IndexPath) -> SideMenuCell {
        return manager.getCellByIndexPath(indexPath: indexPath)
    }
    
    func getCellInfoByIndexPath(indexPath: IndexPath) -> SideMenuCellInfo {
        return manager.getCellInfoByIndexPath(indexPath: indexPath)
    }
    
    func getSectionCount() -> Int {
        return manager.getSectionCount()
    }
}

class SideMenuCellManager {
    static let shared = SideMenuCellManager()
    private init() { }
    // sidebar에 xib파일을 만들때마다 다음 storageData배열에 직접 추가해줘야함(단, xib파일은 SideMenuCellView프로토콜을 따른다)
    private var storageData: [SideMenuCellInfo] = [TestView1_1.sideMenuCellInfo, TestView1_2.sideMenuCellInfo, TestView2_1.sideMenuCellInfo, TestView3_1.sideMenuCellInfo]
    
    func getCellsBySection(section: Int) -> [SideMenuCellInfo] {
        let validDatas = self.storageData.filter { data in
            if (data.section?.rawValue == section) {
                return true
            }
            return false
        }
        return validDatas
    }
    
    func getAllCells() -> [SideMenuCellInfo] {
        return self.storageData
    }
    
    func getCellByIndexPath(indexPath: IndexPath) -> SideMenuCell {
        let cellsInfo = self.getCellsBySection(section: indexPath.section)
        let cellInfo = cellsInfo[indexPath.row]
        let cell = SideMenuCell(info: cellInfo)
        return cell
    }
    
    func getCellInfoByIndexPath(indexPath: IndexPath) -> SideMenuCellInfo {
        let cellsInfo = self.getCellsBySection(section: indexPath.section)
        return cellsInfo[indexPath.row]
    }
    
    func getSectionCount() -> Int {
        return SideMenuSection.count
    }
}
