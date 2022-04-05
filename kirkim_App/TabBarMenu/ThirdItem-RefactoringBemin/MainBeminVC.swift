//
//  MainBeminVC.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainBeminVC: UIViewController {
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let viewModel = MainBeminViewModel()
    private let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        self.collectionView.register(StaticSectionCell.self, forCellWithReuseIdentifier: "test1")
        self.collectionView.collectionViewLayout = createLayout()
//        self.collectionView.refreshControl = UIRefreshControl()
//        self.collectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        print("hello")
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
        
    }
    
    private func layout() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        let staticSectionViewModel = viewModel.staticSectionViewModel
        
        viewModel.cellData
            .drive(collectionView.rx.items) { cv, row, data in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "test1", for: IndexPath(row: row, section: 0)) as! StaticSectionCell
                cell.bind(staticSectionViewModel)
                staticSectionViewModel.presentVC.drive { [weak self] vc in
                    self?.present(vc, animated: true)
                }
                .disposed(by: self.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            return section
        }
    }
}
