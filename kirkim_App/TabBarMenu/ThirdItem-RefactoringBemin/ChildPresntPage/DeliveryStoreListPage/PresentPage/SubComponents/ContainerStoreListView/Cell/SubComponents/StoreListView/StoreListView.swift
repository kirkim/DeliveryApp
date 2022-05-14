//
//  StoreListView.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import UIKit
import RxSwift
import RxCocoa

class StoreListView: UICollectionView {
    private let disposeBag = DisposeBag()
    private let sectionManager = StoreListSectionManager()
    private var model: StoreListModel?
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model : StoreListModel) {
        self.model = model
        let dataSource = model.dataSource()
        model.cellData
            .bind(to: self.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func bind(_ viewModel: StoreListViewModel) {
        guard let model = model else {
            return
        }
        self.rx.itemSelected.withLatestFrom(model.cellData) { indexPath, cellData in
            return cellData[indexPath.section].items[indexPath.row].storeCode
        }
        .bind(to: viewModel.presentStoreDetailVC)
        .disposed(by: disposeBag)
//        viewModel.presentStoreDetailVC
//            .bind { storeCode in
//                self.httpModel.loadData(code: storeCode) {
//                    DispatchQueue.main.async {
//                        let vc = MagnetBarView()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }
//
//            }
    }
    
    private func attribute() {
        self.register(cellType: StoreListCell.self)
        self.delegate = self
        self.showsVerticalScrollIndicator = false
    }
}

//MARK: - StoreListView: UICollectionViewDelegateFlowLayout
extension StoreListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        let height = self.frame.height/8
        return CGSize(width: width , height: height)
    }
}
