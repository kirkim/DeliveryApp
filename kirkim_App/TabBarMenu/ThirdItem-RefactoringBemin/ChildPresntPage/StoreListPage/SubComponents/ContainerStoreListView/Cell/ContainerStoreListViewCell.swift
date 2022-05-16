//
//  ContainerStoreListViewCell.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import UIKit

class ContainerStoreListViewCell: UICollectionViewCell {
    private var flag:Bool = false
    private let storeListView = StoreListView()
    private let storeListModel = StoreListModel()
//    private let storeListViewModel = StoreListViewModel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setModel() {
        self.storeListView.setModel(storeListModel)
    }
    
    func setData(data: [StoreListSection]) {
        self.storeListModel.updateData(data: data)
    }
    
    func bind(_ viewModel: StoreListViewModel) {
        self.storeListView.bind(viewModel)
    }
    
    private func layout() {
        [storeListView].forEach {
            self.addSubview($0)
        }
        
        storeListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
}
