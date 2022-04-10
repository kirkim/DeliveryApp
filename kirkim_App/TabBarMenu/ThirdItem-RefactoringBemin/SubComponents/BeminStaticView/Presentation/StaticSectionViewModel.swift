//
//  StaticSectionLayoutManager.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct StaticSectionViewModel {
    var sectionContents: [RxStaticSectionData]
    private var sectionUIType: [StaticCellUIType]
    private let staticSectionModel = StaticSectionModel()
    
    private let disposeBag = DisposeBag()
    // View -> ViewModel
    let itemSelected = PublishRelay<IndexPath>()
    // ViewModel -> View
    let presentVC: Driver<UIViewController>
    
    init() {
        guard let path = Bundle.main.path(forResource: "BeminStaticContent", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let parsingPlist = try? PropertyListDecoder().decode([BeminStaticContent].self, from: data)
        else {
            fatalError()
        }
        
        self.sectionUIType = parsingPlist.map{ $0.sectionType }
        self.sectionContents = parsingPlist.map { RxStaticSectionData(items: $0.contentItem) }
        
        itemSelected.bind(to: staticSectionModel.itemSelected)
            .disposed(by: disposeBag)
        
        presentVC = staticSectionModel.presentVC
    }
    
    // RxDataSources 형식으로 만든 셀 데이터
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<RxStaticSectionData> {
        return RxCollectionViewSectionedReloadDataSource<RxStaticSectionData>(
            configureCell: { dataSource, collectionView, indexPath, item in
                var cell: StaticCellProtocol
                let staticSectionType = sectionUIType[indexPath.section]
                switch staticSectionType {
                case .big:
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBigCell.cellId, for: indexPath)  as! StaticCellProtocol
                case .medium:
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticMediumCell.cellId, for: indexPath)  as! StaticCellProtocol
                case .medium_2:
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticMedium_2Cell.cellId, for: indexPath)  as! StaticCellProtocol
                case .small_3:
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticSmall_3Cell.cellId, for: indexPath)  as! StaticCellProtocol
                case .small_4:
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticSmall_4Cell.cellId, for: indexPath)  as! StaticCellProtocol
                case .banner:
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticBannerCell.cellId, for: indexPath) as! StaticCellProtocol
                }
                cell.setData(item: item)
                return cell as! UICollectionViewCell
            })
    }
    
    //MARK: - StaticSectionViewModel: Layout Function
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.staticSectionLayout(sectionNumber: sectionNumber)
        }
    }
    
    func staticSectionLayout(sectionNumber: Int) -> NSCollectionLayoutSection {
        let staticSectionType = sectionUIType[sectionNumber]
    
        switch staticSectionType {
        case .big:
            return self.bigSection()
        case .medium:
            return self.mediumSection()
        case .medium_2:
            return self.medium_2Section()
        case .small_3:
            return self.small_3Section()
        case .small_4:
            return self.small_4Section()
        case .banner:
            return self.bannerSection()
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
    
    private func bigSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(bigHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func mediumSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func medium_2Section() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: itemSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(midiumHeight)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-itemSpacing)
        return section
    }
    
    private func small_3Section() -> NSCollectionLayoutSection {
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
    
    private func small_4Section() -> NSCollectionLayoutSection {
        let sevenSpacing:CGFloat = 1
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: sevenSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(smallHeight)), subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topMargin, leading: sideMargin, bottom: bottomMargin, trailing: sideMargin-sevenSpacing)
        return section
    }
}
