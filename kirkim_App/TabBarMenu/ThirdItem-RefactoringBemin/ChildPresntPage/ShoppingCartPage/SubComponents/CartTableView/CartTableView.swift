//
//  CartCollectionView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import RxSwift
import RxCocoa

class CartTableView: UITableView {
    private let disposeBag = DisposeBag()
    private let cartManager = CartManager.shared
    
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        attribute()
        layout()
//        bind(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CartTableViewModel) {
        let datasource = viewModel.dataSource()
        viewModel.data
            .bind(to: self.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .systemGray6
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        self.separatorColor = .systemGray6
        self.delegate = self
        let cartItemNib = UINib(nibName: "CartItemCell", bundle: nil)
        self.register(cartItemNib, forCellReuseIdentifier: "CartItemCell")
        self.register(cellType: CartPriceCell.self)
        self.register(cellType: CartTypeCell.self)
        self.register(cellType: CartWarningMessageCell.self)
        self.register(headerFooterViewType: CartItemHeaderView.self)
        self.register(headerFooterViewType: CartItemFooterView.self)
        self.sectionHeaderTopPadding = 10
    }
    
    private func layout() {
        
    }
}

extension CartTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 100
        case 2:
            return 150
        case 3:
            return 80
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let header = tableView.dequeueReusableHeaderFooterView(CartItemHeaderView.self)
            let storeName = cartManager.getStoreName()
            let storeThumbnail = cartManager.getStoreThumbnail()
            header?.setData(storeName, storeThumbnail)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 50
        }
        return 0
    }
    
    // Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == 0) {
            let footer = tableView.dequeueReusableHeaderFooterView(CartItemFooterView.self)
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 50
        }
        return 0
    }
}
