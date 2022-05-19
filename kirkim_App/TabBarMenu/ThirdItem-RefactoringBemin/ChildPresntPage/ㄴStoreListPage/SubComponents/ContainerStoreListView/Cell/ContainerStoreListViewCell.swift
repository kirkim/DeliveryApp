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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setData(data: [StoreListSection], type: StoreType) {
        self.storeListView.setData(data: data, type: type)
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
