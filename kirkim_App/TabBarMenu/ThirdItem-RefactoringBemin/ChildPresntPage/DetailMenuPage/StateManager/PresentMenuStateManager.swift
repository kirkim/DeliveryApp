//
//  PageMaker.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/13.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class PresentMenuStateManager {
    private var headerSectionItem: PresentMenuTitleItem
    private var optionSectionItem: [PresentMenuReactItem] = []
    private var countSectionItem: PresentSelectCountItem
    let sectionTotalCount: Int
    private let httpManager = HttpModel.shared
    
    // Observer
    private let collectionViewDataObserver: BehaviorRelay<[PresentMenuSectionModel]>
    private let errorMessageObserver = PublishRelay<String>()
    private let totalPriceObserver = BehaviorRelay<Int>(value: 0)
    private let isValidObserver = BehaviorRelay<Bool>(value: false)
    
    // Data Storage for ShoppingCart
//    private let storeCode: String
    private let indexPath: IndexPath
    
    init(model: MagnetPresentMenuModel) {
        // 초기 데이터 세팅
        self.collectionViewDataObserver = BehaviorRelay<[PresentMenuSectionModel]>(value: model.data)
        self.sectionTotalCount = model.data.count
//        self.storeCode = httpManager.getStoreCode()
        self.indexPath = model.indexPath
        // 섹션별로 분류
        self.headerSectionItem = model.data[0].items[0] as! PresentMenuTitleItem
        let lastIndex = model.data.count - 1
        self.countSectionItem = model.data[lastIndex].items[0] as! PresentSelectCountItem
        var price:Int = 0
        for i in 1..<lastIndex {
            let data = model.data[i]
            let items = (data.items as! [PresentMenuItem])
            let item = PresentMenuReactItem(header: data.headers!, selectType: data.selectType!, items: items)
            optionSectionItem.append(item)
            price += self.manageMenu(items)
        }
        
        price = self.countSectionItem.count * price
        self.totalPriceObserver.accept(price)
    }
    
    //MARK: - Private Method
    
    /// manageMenu
    /// 반환:  매뉴의 선택한 옵션의 가격의 총합
    private func manageMenu(_ items: [PresentMenuItem]) -> Int {
        var price:Int = 0
        items.forEach { menu in
            if (menu.isSelected == true) {
                price += menu.price ?? 0
            }
        }
        return price
    }
    
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
            price += self.manageMenu(item.items)
        }
        price = price * self.countSectionItem.count
        self.totalPriceObserver.accept(price)
        
        // 카운트섹션파싱
        let countData = PresentMenuSectionModel.SectionSelectCount(items: [self.countSectionItem])
        resultData.append(countData)
        updateValid()
        self.collectionViewDataObserver.accept(resultData)
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
    func getCollectionViewDataObserver() -> BehaviorRelay<[PresentMenuSectionModel]> {
        return self.collectionViewDataObserver
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
    
    func parsingCartData() -> ParsedCartData {
        let storeName = httpManager.getStoreName()
        let storeCode = httpManager.getStoreCode()
        
        var menuString: [String] = []
        var totalPrice:Int = 0
        self.optionSectionItem.forEach { section in
            var menuArray: [String] = []
            section.items.forEach { item in
                if (item.isSelected) {
                    menuArray.append("\(item.title)(\((item.price ?? 0).parsingToKoreanPrice()))")
                    totalPrice += item.price ?? 0
                }
            }
            if (!menuArray.isEmpty) {
                let sectionString = "∙\(section.header): \(menuArray.joined(separator: "/"))"
                menuString.append(sectionString)
            }
        }
        
        let imageData = (self.headerSectionItem.image ?? UIImage(systemName: "circle"))!.pngData()!
        
        let item = CartMenuItem(indexPath: self.indexPath, title: self.headerSectionItem.mainTitle, thumbnailUrl: imageData, menuString: menuString, price: totalPrice, count: self.countSectionItem.count)
        
        let deliveryTip = httpManager.getDeliveryTip()
        
        return ParsedCartData(storeName: storeName, storeCode: storeCode, deliveryTip: deliveryTip, item: item)
    }
}
