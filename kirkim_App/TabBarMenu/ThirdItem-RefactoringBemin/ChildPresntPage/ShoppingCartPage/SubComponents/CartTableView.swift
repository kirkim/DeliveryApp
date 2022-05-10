//
//  CartCollectionView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit

class CartTableView: UICollectionView {
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        let cartItemNib = UINib(nibName: "CartItemCell", bundle: nil)
        self.register(cartItemNib, forCellWithReuseIdentifier: "CartItemCell")
    }
    
    private func layout() {
        
    }
}
