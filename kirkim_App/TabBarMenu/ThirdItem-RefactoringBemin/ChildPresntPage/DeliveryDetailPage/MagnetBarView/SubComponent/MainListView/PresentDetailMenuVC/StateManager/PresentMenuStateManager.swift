//
//  PageMaker.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/13.
//

import Foundation
import RxSwift
import RxCocoa

class PresentMenuStateManager {
    private var headerSectionItem: PresentMenuTitleItem
    private var optionSectionItem: [PresentMenuReactItem] = []
    private var countSectionItem: PresentSelectCountItem
    let sectionTotalCount: Int
    private let dataObserver: BehaviorRelay<[PresentMenuSectionModel]>
    private let errorMessageObserver = PublishRelay<String>()
    private let totalPriceObserver: BehaviorRelay<Int>
    private let isValidObserver = BehaviorRelay<Bool>(value: false)
    
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
        self.totalPriceObserver = BehaviorRelay<Int>(value: price)
    }
    
    //MARK: - Private Method
    private func update() {
        var resultData: [PresentMenuSectionModel] = []
        
        // 헤더섹션파싱
        let headerData = PresentMenuSectionModel.SectionMainTitle(items: [self.headerSectionItem])
        resultData.append(headerData)
        
        // 매뉴섹션파싱
        var price:Int = 0
        self.optionSectionItem.forEach { item in
            let optionItem = PresentMenuSectionModel.SectionMenu(header: item.header, selectType: item.selectType, items: item.items)
            resultData.append(optionItem)
            item.items.forEach { item in
                if (item.isSelected == true) {
                    price += item.price ?? 0
                }
            }
        }
        price = price * self.countSectionItem.count
        self.totalPriceObserver.accept(price)
        
        // 카운트섹션파싱
        let countData = PresentMenuSectionModel.SectionSelectCount(items: [self.countSectionItem])
        resultData.append(countData)
        updateValid()
        self.dataObserver.accept(resultData)
    }
    
    private func updateValid() {
        var notValidSection:Int = 0
        self.optionSectionItem.forEach { section in
            var isValidCount:Int = 0
            switch section.selectType {
            case .custom(let min, _):
                isValidCount = min
                section.items.forEach { item in
                    isValidCount = item.isSelected == true ? isValidCount-1 : isValidCount
                }
                notValidSection = isValidCount <= 0 ? notValidSection : notValidSection+1
            case .mustOne:
                break;
            }
        }
        let isValid = notValidSection == 0 ? true : false
        isValidObserver.accept(isValid)
    }
    
    
    //MARK: - Public Method
    func getDataObserver() -> BehaviorRelay<[PresentMenuSectionModel]> {
        return self.dataObserver
    }
    
    func getTotalPriceObserver() -> BehaviorRelay<Int> {
        return self.totalPriceObserver
    }
    
    func getErrorMessageObserver() -> PublishRelay<String> {
        return self.errorMessageObserver
    }
    
    func getIsValidObserver() -> BehaviorRelay<Bool> {
        return self.isValidObserver
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
                    errorMessageObserver.accept("\(max)개까지 선택이 가능합니다")
                } else {
                    section.changeState(row: row, state: true)
                }
            }
        }
        self.optionSectionItem[index] = section
        update()
    }
}
