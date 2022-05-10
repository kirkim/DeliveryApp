//
//  TabBar.swift
//  CustomTabBar
//
//  Created by 김기림 on 2022/04/07.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TopBar: UICollectionView {
    private let disposeBag = DisposeBag()
    private var cellData: [String]?
    private let startPage: Int
    private var flag: Bool = false
    private var selectedPage: Int
    
    init(startPage: Int) {
        self.startPage = startPage
        self.selectedPage = startPage
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TopBarViewModel) {
        self.cellData = viewModel.data
        Driver.just(viewModel.data)
            .drive(self.rx.items(cellIdentifier: "TopBarCell", cellType: TopBarCell.self)) { [weak self] row, data, cell in
                cell.setData(title: data)
                if (self?.flag == false) {
                    self?.scrollToItem(at: IndexPath(row: (self?.startPage)!, section: 0), at: .centeredHorizontally, animated: true)
                }
                if ((row == self?.startPage && self?.flag == false) || (row == self?.selectedPage)) {
                    self?.flag = true
                    cell.isValid(true)
                }
            }
            .disposed(by: disposeBag)
        
        self.rx.itemSelected
            .distinctUntilChanged()
            .bind(to: viewModel.slotChanged)
            .disposed(by: disposeBag)
        
        viewModel.slotChanging
            .bind { [weak self] indexPath in
                self?.visibleCells.forEach { cell in
                    (cell as? TopBarCell)?.isValid(false)
                }
                guard let cell = self?.cellForItem(at: indexPath) as? TopBarCell else { return }
                cell.isValid(true)
                self?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self?.selectedPage = indexPath.row
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: attribute(), layout() function
    private func attribute() {
        self.delegate = self
        self.register(TopBarCell.self, forCellWithReuseIdentifier: "TopBarCell")
    }
    
    private func layout() {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
    }
}

//MARK: - TabBar: UICollectionViewDelegateFlowLayout
extension TopBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let slot = self.cellData?[indexPath.row] else { return CGSize.zero }
        let length = slot.count * 15 + 20
        return CGSize(width: length , height: Int(self.frame.height)-20)
    }
}
