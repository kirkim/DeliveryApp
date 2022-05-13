//
//  PageMaker.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/13.
//

import Foundation
import RxSwift
import RxCocoa



struct PresentMenuReactItem {
    var header: String
    let selectType: SelectType
    var items: [PresentMenuItem]
    
    mutating func changeState(row: Int, state: Bool) {
        self.items[row].isSelected = state
    }
    
    mutating func changeAllStateToFalse() {
        for i in 0..<self.items.count {
            self.items[i].isSelected = false
        }
    }
    
    func countOfSelectedItems() -> Int {
        var count = 0
        self.items.forEach { item in
            if (item.isSelected == true) {
                count += 1
            }
        }
        return count
    }
}

class PresentMenuStateManager {
    private let dataObserver: BehaviorRelay<[PresentMenuSectionModel]>
    private var headerSectionItem: PresentMenuTitleItem
    private var optionSectionItem: [PresentMenuReactItem] = []
    private var countSectionItem: PresentSelectCountItem
    let sectionTotalCount: Int
    private let errorMessage = PublishRelay<String>()
    private let totalPrice: BehaviorRelay<Int>
    
    
    init(model: MagnetPresentMenuModel) {
        // 초기 데이터 세팅
        self.dataObserver = BehaviorRelay<[PresentMenuSectionModel]>(value: model.data)
        self.sectionTotalCount = model.data.count
        // 섹션별로 분류
        self.headerSectionItem = model.data[0].items[0] as! PresentMenuTitleItem
        let lastIndex = model.data.count - 1
        var price:Int = 0
        for i in 1..<lastIndex {
            let data = model.data[i]
            let items = (data.items as! [PresentMenuItem])
            let item = PresentMenuReactItem(header: data.headers!, selectType: data.selectType!, items: items)
            optionSectionItem.append(item)
            items.forEach { menu in
                if (menu.isSelected == true) {
                    price += menu.price ?? 0
                }
            }
        }
        self.countSectionItem = model.data[lastIndex].items[0] as! PresentSelectCountItem
        price = self.countSectionItem.count * price
        self.totalPrice = BehaviorRelay<Int>(value: price)
    }
    
    //MARK: Private Method
    private func update() {
        var resultData: [PresentMenuSectionModel] = []
        
        // 헤더섹션파싱
        let headerData = PresentMenuSectionModel.SectionMainTitle(items: [self.headerSectionItem])
        resultData.append(headerData)
        
        // 매뉴섹션파싱
        self.optionSectionItem.forEach { item in
            let optionItem = PresentMenuSectionModel.SectionMenu(header: item.header, selectType: item.selectType, items: item.items)
            resultData.append(optionItem)
        }
        
        // 카운트섹션파싱
        let countData = PresentMenuSectionModel.SectionSelectCount(items: [self.countSectionItem])
        resultData.append(countData)
        
        self.dataObserver.accept(resultData)
    }
    
    
    //MARK: Public Method
    func getDataObserver() -> BehaviorRelay<[PresentMenuSectionModel]> {
        return self.dataObserver
    }
    
    func changeCount(value: Int) {
        self.countSectionItem = PresentSelectCountItem(count: value)
        update()
    }
    
    func itemSelect(_ indexPath: IndexPath) {
        if (indexPath.section == 0 || indexPath.section == self.sectionTotalCount-1) {
            return
        }
        let index = indexPath.section - 1
        let row = indexPath.row
        var section = self.optionSectionItem[indexPath.section - 1]
        switch section.selectType {
        case .mustOne:
            if (section.items[row].isSelected == true) {
                return
            } else {
                section.changeAllStateToFalse()
                section.changeState(row: row, state: true)
            }
        case .custom(_, let max):
            if (section.items[row].isSelected == true) {
                section.changeState(row: row, state: false)
            } else {
                if (section.countOfSelectedItems() >= max && max != 0) {
                    errorMessage.accept("\(max)개까지 선택이 가능합니다")
                } else {
                    section.changeState(row: row, state: true)
                }
            }
        }
        self.optionSectionItem[index] = section
        update()
    }
}
