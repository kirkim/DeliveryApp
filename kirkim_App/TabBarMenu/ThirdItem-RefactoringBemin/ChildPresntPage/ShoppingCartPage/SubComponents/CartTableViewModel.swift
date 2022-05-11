//
//  CartCollectionViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import RxDataSources

struct CartTableViewModel {
    let cartManager = CartManager.shared
    let data:[ShoppingCartSectionModel]
    
//    let cartItemViewModel = CartItemViewModel()
    let cartTypeViewModel = CartTypeViewModel()
    
    init() {
        self.data = cartManager.getData()
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
