//
//  Bemin+StaticSection.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/09.
//

import UIKit

class StaticCollection {
    enum Section: Int, CaseIterable {
        case main
        case takeout
        case bMart
        case beminStore
        case etc
        case banner
        case userInfo
    }
    static let itemSpacing: CGFloat = 16
    static let sideMargin: CGFloat = 16
    static let topMargin: CGFloat = 10
    static let bottomMargin: CGFloat = 5
    
    static let bigHeight: CGFloat = 0.5
    static let smallHeight: CGFloat = 0.2
    static let midiumHeight: CGFloat = 0.25
    static let bannerHeight: CGFloat = 0.35
    
    static func numberOfStaticItem(section: Int) -> Int {
        switch section {
        case Section.main.rawValue:
            return 2
        case Section.takeout.rawValue:
            return 1
        case Section.bMart.rawValue:
            return 2
        case Section.beminStore.rawValue:
            return 1
        case Section.etc.rawValue:
            return 3
        case Section.banner.rawValue:
            return 1
        case Section.userInfo.rawValue:
            return 4
        default:
            return 0
        }
    }
    
    static func staticSectionLayout(sectionNumber: Int) -> NSCollectionLayoutSection {
        switch sectionNumber {
        case Section.main.rawValue:
            return StaticCollection.mainSection()
        case Section.takeout.rawValue:
            return StaticCollection.takeoutSection()
        case Section.bMart.rawValue:
            return StaticCollection.bMartSection()
        case Section.beminStore.rawValue:
            return StaticCollection.beminStoreSection()
        case Section.etc.rawValue:
            return StaticCollection.etcSection()
        case Section.banner.rawValue:
            return StaticCollection.bannerSection()
        case Section.userInfo.rawValue:
            return StaticCollection.userInfo()
        default:
            return StaticCollection.mainSection()
        }
    }
    
    static func mainSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(bigHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    static func takeoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    static func bMartSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(midiumHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    static func beminStoreSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    static func etcSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    static func bannerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(bannerHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    static func userInfo() -> NSCollectionLayoutSection {
        let sevenSpacing:CGFloat = 1
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: sevenSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-sevenSpacing)
        return section
    }
}
