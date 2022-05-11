//
//  CartManager.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/11.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    private var data: [ShoppingCartSectionModel]?
    private var itemDatas: [CartMenuItem]?
    private var cartTypeData: CartTypeItem?
    private var priceData: CartPriceItem?
    
    let userDefaults = UserDefaults(suiteName: "ShoppingCart")!
    
    private init() {
        if let items = getItem() {
            let type = getType()
            let price = getPrice()
            let itemData = ShoppingCartSectionModel.cartMenuSection(items: items)
            let cartTypeData = ShoppingCartSectionModel.cartTypeSection(items: [type])
            let priceData = ShoppingCartSectionModel.cartPriceSection(items: [price])
            data = [itemData, cartTypeData, priceData]
        }
    }
    
    func getData() -> [ShoppingCartSectionModel] {
        guard let data = data else {
            return []
        }
        return data
    }
    
    func saveItem(data: [CartMenuItem]) {
        self.itemDatas = data
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            userDefaults.setValue(encoded, forKey: "item")
        }
    }
    
    func changeItemCount(indexPath: IndexPath) {
        guard let itemDatas = itemDatas else {
            return
        }

        let changeItem = itemDatas
    }
    
    func getItem() -> [CartMenuItem]? {
        if let savedData = userDefaults.object(forKey: "item") as? Data {
            let decoder = JSONDecoder()
            let savedObject = try? decoder.decode([CartMenuItem].self, from: savedData)
            return savedObject
        }
        return nil
    }
    
    func saveType(data: CartTypeItem) {
        self.cartTypeData = data
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            userDefaults.setValue(encoded, forKey: "type")
        }
    }
    
    func getType() -> CartTypeItem {
        if let savedData = userDefaults.object(forKey: "type") as? Data {
            let decoder = JSONDecoder()
            let savedObject = try? decoder.decode(CartTypeItem.self, from: savedData)
            return savedObject ?? CartTypeItem(type: .delivery)
        }
        return CartTypeItem(type: .delivery)
    }
    
    func savePrcie(data: CartPriceItem) {
        self.priceData = data
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            userDefaults.setValue(encoded, forKey: "price")
        }
    }
    
    func getPrice() -> CartPriceItem {
        if let savedData = userDefaults.object(forKey: "price") as? Data {
            let decoder = JSONDecoder()
            let savedObject = try? decoder.decode(CartPriceItem.self, from: savedData)
            return savedObject ?? CartPriceItem(totalPrice: 0, deliveryPrice: 0)
        }
        return CartPriceItem(totalPrice: 0, deliveryPrice: 0)
    }
}
