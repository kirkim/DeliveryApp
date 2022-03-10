//
//  Bemin+StaticSection.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/09.
//

import UIKit

class StaticSectionModel {
    private let manager = StaticSectionManager()
    
    // 스테틱 셀 아이템 갯수
    func numberOfStaticItem(section: Int) -> Int {
        return manager.numberOfStaticItem(section: section)
    }
    
    // 스테틱 셀의 섹션레이아웃(
    func staticSectionLayout(sectionNumber: Int) -> NSCollectionLayoutSection {
        return manager.staticSectionLayout(sectionNumber: sectionNumber)
    }
    
    // 스테틱 섹션(Section)의 갯수
    func getStaticSectionTotalCount() -> Int {
        return manager.getStaticSectionTotalCount()
    }
    
    // 스테틱 섹션에 사용할 셀 클래스(Cell Class)를 부모 콜렉션뷰에 등록해줌
    func registerCells(on collectionView: UICollectionView) {
        return manager.registerCells(on: collectionView)
    }
    
    // indexPath에 맞는 셀(Cell)을 가공해서 반환해줌
    func getCellBySection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return manager.getCellBySection(collectionView, cellForItemAt: indexPath)
    }
}


class StaticSectionManager {
    enum StaticSection: Int, CaseIterable {
        case main
        case takeout
        case bMart
        case beminStore
        case etc
        case banner
        case userInfo
        
        var cellID: String {
            switch self {
            case .main:
                return "mainCell"
            case .takeout:
                return "takeoutCell"
            case .bMart:
                return "bMartCell"
            case .beminStore:
                return "beminStoreCell"
            case .etc:
                return "etcCell"
            case .banner:
                return "bannerCell"
            case .userInfo:
                return "userInfoCell"
            }
        }
    }
    
    private let itemSpacing: CGFloat = 16
    private let sideMargin: CGFloat = 16
    private let topMargin: CGFloat = 10
    private let bottomMargin: CGFloat = 5
    
    private let bigHeight: CGFloat = 0.5
    private let smallHeight: CGFloat = 0.2
    private let midiumHeight: CGFloat = 0.25
    private let bannerHeight: CGFloat = 0.35
    
    func getStaticSectionTotalCount() -> Int {
        return StaticSection.allCases.count
    }
    
    func registerCells(on collectionView: UICollectionView) {
        collectionView.register(StaticBigCell.self, forCellWithReuseIdentifier: StaticBigCell.cellId)
        collectionView.register(StaticMediumCell.self, forCellWithReuseIdentifier: StaticMediumCell.cellId)
        collectionView.register(StaticSmallCell.self, forCellWithReuseIdentifier: StaticSmallCell.cellId)
        collectionView.register(StaticBannerCell.self, forCellWithReuseIdentifier: StaticBannerCell.cellId)
    }
    
    func getCellBySection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case StaticSection.main.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBigCell.cellId, for: indexPath) as? StaticBigCell else { return UICollectionViewCell() }
            return cell
        case StaticSection.takeout.rawValue, StaticSection.bMart.rawValue, StaticSection.beminStore.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticMediumCell.cellId, for: indexPath) as? StaticMediumCell else { return UICollectionViewCell() }
            return cell
        case StaticSection.etc.rawValue, StaticSection.userInfo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticSmallCell.cellId, for: indexPath) as? StaticSmallCell else { return UICollectionViewCell() }
            return cell
        case StaticSection.banner.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.cellId, for: indexPath) as? StaticBannerCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func numberOfStaticItem(section: Int) -> Int {
        switch section {
        case StaticSection.main.rawValue:
            return 2
        case StaticSection.takeout.rawValue:
            return 1
        case StaticSection.bMart.rawValue:
            return 2
        case StaticSection.beminStore.rawValue:
            return 1
        case StaticSection.etc.rawValue:
            return 3
        case StaticSection.banner.rawValue:
            return 1
        case StaticSection.userInfo.rawValue:
            return 4
        default:
            return 0
        }
    }
    
    func staticSectionLayout(sectionNumber: Int) -> NSCollectionLayoutSection {
        switch sectionNumber {
        case StaticSection.main.rawValue:
            return self.mainSection()
        case StaticSection.takeout.rawValue:
            return self.takeoutSection()
        case StaticSection.bMart.rawValue:
            return self.bMartSection()
        case StaticSection.beminStore.rawValue:
            return self.beminStoreSection()
        case StaticSection.etc.rawValue:
            return self.etcSection()
        case StaticSection.banner.rawValue:
            return self.bannerSection()
        case StaticSection.userInfo.rawValue:
            return self.userInfo()
        default:
            return self.mainSection()
        }
    }
    
    private func mainSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(bigHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func takeoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func bMartSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(midiumHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func beminStoreSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func etcSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func bannerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(bannerHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func userInfo() -> NSCollectionLayoutSection {
        let sevenSpacing:CGFloat = 1
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: sevenSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-sevenSpacing)
        return section
    }
}
