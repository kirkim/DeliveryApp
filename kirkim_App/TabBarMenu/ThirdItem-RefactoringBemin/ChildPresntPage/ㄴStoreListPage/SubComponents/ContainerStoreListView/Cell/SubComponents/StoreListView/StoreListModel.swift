//
//  StoreListModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/09.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class StoreListModel {
    private let disposeBag = DisposeBag()
    
    let cellData = PublishRelay<[StoreListSection]>()
    private var MenuImageStorage:[String:UIImage] = [:]
    
    func updateData(data: [StoreListSection]) {
        cellData.accept(data)
    }
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<StoreListSection> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<StoreListSection>(
            configureCell: { dataSource, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: StoreListCell.self)
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
            let image = data != nil ? UIImage(data: data!) : UIImage(systemName: "icloud.slash")!
            DispatchQueue.main.async {
                if let image = image { self.MenuImageStorage.updateValue(image, forKey: urlString) }
            }
            return image ?? UIImage()
        }
    }
}
