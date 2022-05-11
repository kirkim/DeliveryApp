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
    
    //temp
    let viewModel = CartTableViewModel()
    
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        attribute()
        layout()
        bind(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CartTableViewModel) {
        let datasource = viewModel.dataSource()
        Observable.just(viewModel.data)
            .bind(to: self.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.delegate = self
        let cartItemNib = UINib(nibName: "CartItemCell", bundle: nil)
        self.register(cartItemNib, forCellReuseIdentifier: "CartItemCell")
        self.register(cellType: CartPriceCell.self)
        self.register(cellType: CartTypeCell.self)
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
            return 300
        default:
            return UITableView.automaticDimension
        }
    }
}
