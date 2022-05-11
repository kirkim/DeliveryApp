//
//  CartCollectionViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import RxDataSources

struct CartTableViewModel {
    let data:[ShoppingCartSectionModel] = [
        ShoppingCartSectionModel.cartMenuSection(items: [
            CartMenuItem(title: "토시살스테이크 세트", thumbnailUrl: "", menuString: ["음료 추가: 펨시 355ml", "사리 추가: 우동사리", "서비스: 콘칩"], price: 22500, count: 3),
            CartMenuItem(title: "햄버거 세트", thumbnailUrl: "", menuString: [], price: 6500, count: 2),
            CartMenuItem(title: "파스타 세트", thumbnailUrl: "", menuString: [], price: 12500, count: 1),
        ]),
        ShoppingCartSectionModel.cartTypeSection(items: [CartTypeItem(type: .delivery)]),
        ShoppingCartSectionModel.cartPriceSection(items: [CartPriceItem(totalPrice: 22500, deliveryPrice: 300)])
    ]
    
//    let cartItemViewModel = CartItemViewModel()
    let cartTypeViewModel = CartTypeViewModel()
    
    init() {
        
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<ShoppingCartSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<ShoppingCartSectionModel>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch dataSource[indexPath.section] {
                case .cartMenuSection(items: let items):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as? CartItemCell else { return UITableViewCell() }
                    cell.setData(data: items[indexPath.row], indexPath: indexPath)
//                    cell.bind(cartItemViewModel)
                    return cell
                case .cartTypeSection(items: let items):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CartTypeCell.self)
                    cell.setData(type: items[indexPath.row].type)
                    cell.bind(cartTypeViewModel)
                    return cell
                case .cartPriceSection(items: let items):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CartPriceCell.self)
                    return cell
                }
            })
        return dataSource
    }
}
