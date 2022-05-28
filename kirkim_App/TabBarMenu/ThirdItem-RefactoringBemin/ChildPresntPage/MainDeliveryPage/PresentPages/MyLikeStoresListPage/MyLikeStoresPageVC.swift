//
//  MyLikeStoresListVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/28.
//

import UIKit
import SnapKit
import RxSwift

class MyLikeStoresPageVC: UIViewController {
    private let disposeBag = DisposeBag()
    private let collectionView = MyLikeStoresListView()
    private let viewModel = MyLikeStoresPageViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        self.collectionView.bind(viewModel.collectionViewModel)
        viewModel.presentStoreDetailVC
            .emit { storeCode in
                MagnetBarVC.presentView(target: self, type: .basic(storeCode: storeCode))
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.collectionView.update()
    }
    
    private func attribute() {
        self.title = "찜"
    }
    
    private func layout() {
        [collectionView].forEach {
            self.view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
