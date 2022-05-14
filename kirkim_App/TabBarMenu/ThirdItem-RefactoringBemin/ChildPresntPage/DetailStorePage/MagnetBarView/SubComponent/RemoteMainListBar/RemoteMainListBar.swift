//
//  RemoteMainListBar.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RemoteMainListBar: UICollectionView {
    private let disposeBag = DisposeBag()
    private var cellData: [String]?
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: RemoteMainListBarViewModel) {
        self.cellData = viewModel.data
        self.dataSource = nil
        self.visibleCells.forEach {
            $0.backgroundColor = .clear
        }
        Driver.just(viewModel.data)
            .drive(self.rx.items(cellIdentifier: "RemoteMainListBarCell", cellType: RemoteMainListBarCell.self)) { row, data, cell in
                cell.setData(title: data)
                cell.layer.cornerRadius = 15
                cell.layer.borderColor = UIColor.systemMint.cgColor
                cell.layer.borderWidth = 1
            }
            .disposed(by: disposeBag)
        
        self.rx.itemSelected
            .distinctUntilChanged()
            .bind(to: viewModel.slotChanged)
            .disposed(by: disposeBag)
        
        viewModel.slotChanging
            .bind { [weak self] indexPath in
                self?.visibleCells.forEach { cell in
                    cell.backgroundColor = .clear
                    (cell as? RemoteMainListBarCell)?.titleLabel.textColor = .black
                }
                guard let cell = self?.cellForItem(at: indexPath) as? RemoteMainListBarCell else { return }
                self?.cellForItem(at: indexPath)?.backgroundColor = .systemMint
                cell.titleLabel.textColor = .white
                self?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: attribute(), layout() function
    private func attribute() {
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.register(RemoteMainListBarCell.self, forCellWithReuseIdentifier: "RemoteMainListBarCell")
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
extension RemoteMainListBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let slot = self.cellData?[indexPath.row] else { return CGSize.zero }
        var length = slot.size(withAttributes: nil).width*1.5 + 20
        length = length > 150 ? 150 : length
        let height = MagnetBarViewMath.stickyHeaderHeight - 30
        return CGSize(width: length, height: height)
    }
}
