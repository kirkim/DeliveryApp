//
//  SlideStoreListView.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import UIKit
import RxSwift
import RxCocoa

class ContainerStoreListView: UICollectionView {
    private let disposeBag = DisposeBag()
    let nowPage = BehaviorSubject<Int>(value: 0)
    private let startPage: Int
    private var flag:Bool = false
    
    init(startPage: Int) {
        self.startPage = startPage
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: ContainerStoreListViewModel) {
        Driver.just(viewModel.cellData)
            .drive(self.rx.items(cellIdentifier: "ContainerStoreListViewCell", cellType: ContainerStoreListViewCell.self)) { row, data, cell in
                cell.bind(viewModel.storeListViewModel)
                StoreListHttpManager.shared.load(storeType: data) { data in
                    cell.setData(data: data)
                    if (self.flag == false) {
                        self.flag = true
                        DispatchQueue.main.async {
                            self.scrollToItem(at: NSIndexPath(item: self.startPage, section: 0) as IndexPath, at: .centeredHorizontally, animated: false)
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        self.nowPage
            .distinctUntilChanged()
            .bind(to: viewModel.scrollPaged)
            .disposed(by: disposeBag)
        
        viewModel.slotChanged
            .bind { [weak self] row in
                self?.scrollToItem(at: NSIndexPath(item: row, section: 0) as IndexPath, at: .right, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.contentInsetAdjustmentBehavior = .never
        self.delegate = self
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.register(ContainerStoreListViewCell.self, forCellWithReuseIdentifier: "ContainerStoreListViewCell")
    }
}

//MARK: - ContainerStoreListView: UICollectionViewDelegateFlowLayout
extension ContainerStoreListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        let height = self.frame.height
        return CGSize(width: width , height: height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(floor(scrollView.contentOffset.x / scrollView.frame.width))
        self.nowPage.onNext(page)
    }
}
