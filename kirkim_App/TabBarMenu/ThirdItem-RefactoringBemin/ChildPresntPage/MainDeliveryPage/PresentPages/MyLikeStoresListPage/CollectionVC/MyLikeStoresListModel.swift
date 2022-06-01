//
//  MyLikeStoresListModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/28.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class MyLikeStoresListModel {
    private let disposeBag = DisposeBag()
    private let userModel = UserModel()
    private let httpManager = SummaryStoreHttpManager.shared
    
    let cellData = PublishRelay<[StoreListSection]>()
    private var MenuImageStorage:[String:UIImage] = [:]
    
    init() {
    }
    
    func updateData(completion: (() -> ())? = nil) {
        guard let userCode = userModel.info?.id else { return }
        httpManager.load(type: .userCode(code: userCode)) { data in
            self.cellData.accept(data)
            completion?()
        }
    }
    
    func getCellData() -> Observable<[StoreListSection]> {
        return self.cellData.share()
    }
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<StoreListSection> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<StoreListSection>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: StoreListCell.self)
//                let image = self.makeMenuImage(urlString: item.thumbnailUrl)
                cell.setData(data: item)
                DispatchQueue.global().async {
                    let image = self.makeMenuImage(urlString: item.thumbnailUrl)
                    DispatchQueue.main.async {
                        cell.setImage(image: image)
                    }
                }
                return cell
            })
        
        // Header
//        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
//            switch dataSource[indexPath.section] {
//
//            }
//        }
        return dataSource
    }

    private func makeMenuImage(urlString: String) -> UIImage {
        if (MenuImageStorage[urlString] != nil) {
            return MenuImageStorage[urlString]!
        } else {
            guard let url = URL(string: urlString) else { return UIImage(systemName: "circle")! }
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)
            if let image = image { self.MenuImageStorage.updateValue(image, forKey: urlString) }
            return image ?? UIImage()
        }
    }
}
