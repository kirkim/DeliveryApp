//
//  TotalTableView.swift
//  BeminBanner
//
//  Created by 김기림 on 2022/04/11.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TotalBannerListView: UIViewController {
    private let disposeBag = DisposeBag()
    private let cellRatio: CGFloat
    let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(title: String, subTitle: String, cellRatio: CGFloat) {
        self.cellRatio = cellRatio
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        self.title = title
        self.titleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TotalBannerListViewModel) {
        viewModel.cellDataSource
            .drive(self.collectionView.rx.items(cellIdentifier: "TotalBannerListCell", cellType: TotalBannerListCell.self)) { row, data, cell in
                cell.setData(imageData: data.cellImage)
            }
            .disposed(by: disposeBag)
                
        self.collectionView.rx.itemSelected
            .distinctUntilChanged()
            .bind(to: viewModel.cellClicked)
            .disposed(by: disposeBag)
            
        viewModel.presentVC.emit { self.present($0, animated: true) }
            .disposed(by: disposeBag)

    }
    
    private func attribute() {
        self.collectionView.delegate = self
        self.view.backgroundColor = .white
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        self.titleLabel.textAlignment = .center
        
        self.collectionView.register(TotalBannerListCell.self, forCellWithReuseIdentifier: "TotalBannerListCell")
    }
    
    private func layout() {
        [titleLabel, collectionView].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
        }

    }
}

//MARK: - TotalBannerListView: UICollectionViewDelegateFlowLayout
extension TotalBannerListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 40
        let height = width * self.cellRatio
        return CGSize(width: width, height: height)
    }
}
