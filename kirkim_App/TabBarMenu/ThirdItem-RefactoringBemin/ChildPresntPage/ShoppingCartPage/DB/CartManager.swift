//
//  CartManager.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/11.
//

import Foundation
import RxSwift
import RxCocoa

class CartManager {
    static let shared = CartManager()
    
    private var itemDatas: [CartMenuItem]?
    private var totalPrice: Int?
    private var totalPriceObserver: BehaviorRelay<Int>?
    private var deliveryTipObserver: BehaviorRelay<Int>?
    
    private let dataObserver = BehaviorRelay<[ShoppingCartSectionModel]>(value: [])
    private let isValidObserver = BehaviorRelay<Bool>(value: true)
    private let userDefaults = UserDefaults(suiteName: "ShoppingCart")!
    
    private init() {
        load()
        saveItem(data: [
            CartMenuItem(title: "찹스테이크", thumbnailUrl: "", menuString: ["굽기: rare"], price: 20000, count: 3),
            CartMenuItem(title: "포테이토칩", thumbnailUrl: "", menuString: ["salt: 많이", "소스: 머스타드"], price: 5000, count: 7),
            CartMenuItem(title: "투움바 파스타", thumbnailUrl: "", menuString: ["사리: 면사리추가, 소스추가"], price: 15000, count: 2),
        ])
    }
    
    private func load() {
        var dataValue: [ShoppingCartSectionModel] = []
        let items = getItem()
        if (items?.count != 0 && items != nil) {
            let type = getType()
            let deliveryTip = getDeliveryTip()
            
            self.itemDatas = items // 앱을 껏다켰을때 최신데이터를 임시데이터에 저장
            
            let itemData = ShoppingCartSectionModel.cartMenuSection(items: items!)
            let cartTypeData = ShoppingCartSectionModel.cartTypeSection(items: [type])
            let priceData = ShoppingCartSectionModel.cartPriceSection(items: [CartPriceItem(deliveryPrice: deliveryTip)])
            
            var value = 0
            items!.forEach { item in
                value += item.price * item.count
            }
            self.totalPriceObserver = BehaviorRelay<Int>(value: value)
            self.totalPrice = value
            self.deliveryTipObserver = BehaviorRelay<Int>(value: deliveryTip)
            
            dataValue = [itemData, cartTypeData, priceData]
            self.isValidObserver.accept(true)
        } else {
            self.isValidObserver.accept(false)
        }
        dataObserver.accept(dataValue)
    }
    
    func deleteItem(indexPath: IndexPath) {
        guard self.itemDatas != nil else {
            return
        }
        self.itemDatas!.remove(at: indexPath.row)
        saveItem(data: self.itemDatas!)
        load()
    }
    
    func getIsValidObserver() -> BehaviorRelay<Bool> {
        return self.isValidObserver
    }
    
    func getDataObserver() -> BehaviorRelay<[ShoppingCartSectionModel]> {
        load()
        return self.dataObserver
    }
    
    func getTotalPriceObserver() -> BehaviorRelay<Int> {
        guard let totalPriceObserver = totalPriceObserver else {
            fatalError()
        }
        return totalPriceObserver
    }
    
    func getDeliveryTipObserver() -> BehaviorRelay<Int> {
        guard let deliveryTipObserver = deliveryTipObserver else {
            fatalError()
        }
        return deliveryTipObserver
    }
    
    func changeItemCount(indexPath: IndexPath, value: Int) {
        guard var itemDatas = self.itemDatas else {
            return
        }
        let difCount = value - itemDatas[indexPath.row].count
        let difPrice = itemDatas[indexPath.row].price * difCount
        self.totalPrice = (self.totalPrice ?? 0) + difPrice
        self.totalPriceObserver?.accept(self.totalPrice!)
        
        itemDatas[indexPath.row].count = value
        self.saveItem(data: itemDatas)
    }
    
    private func saveItem(data: [CartMenuItem]) {
        self.itemDatas = data // 메뉴아이템섹션의 셀은 여러개 나중에 수정할때 참고하기위한 변수
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            userDefaults.setValue(encoded, forKey: "item")
        }
    }
    
    private func getItem() -> [CartMenuItem]? {
        if let savedData = userDefaults.object(forKey: "item") as? Data {
            let decoder = JSONDecoder()
            let savedObject = try? decoder.decode([CartMenuItem].self, from: savedData)
            return savedObject
        }
        return nil
    }
    
    private func saveType(data: CartTypeItem) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            userDefaults.setValue(encoded, forKey: "type")
        }
    }
    
    private func getType() -> CartTypeItem {
        if let savedData = userDefaults.object(forKey: "type") as? Data {
            let decoder = JSONDecoder()
            let savedObject = try? decoder.decode(CartTypeItem.self, from: savedData)
            return savedObject ?? CartTypeItem(type: .delivery)
        }
        return CartTypeItem(type: .delivery)
    }
    
    private func saveDeliveryTip(data: Int) {
        self.userDefaults.set(data, forKey: "deliveryTip")
        self.deliveryTipObserver?.accept(data)
    }
    
    private func getDeliveryTip() -> Int {
        let savedData = userDefaults.integer(forKey: "deliveryTip")
        return savedData
    }
}
