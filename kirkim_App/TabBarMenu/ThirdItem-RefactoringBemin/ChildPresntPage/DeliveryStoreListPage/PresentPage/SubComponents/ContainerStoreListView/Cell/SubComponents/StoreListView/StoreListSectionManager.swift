//
//  StoreListSectionManager.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import UIKit

struct StoreListSectionManager {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3)), subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
