//
//  TopBarLayoutView.swift
//  CustomTabBar
//
//  Created by 김기림 on 2022/04/07.
//
import UIKit
import RxSwift
import RxCocoa

class TopBarLayoutView: UICollectionView  {
    private let disposeBag = DisposeBag()
    private let startPage: Int
    let nowPage = BehaviorSubject<Int>(value: 0)
    var nowPageFlag: Int = 0
    var initFlag: Bool = false
    
    init(startPage: Int) {
        self.startPage = startPage
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TopBarLayoutViewModel) {
        Driver.just(viewModel.views)
            .drive(self.rx.items(cellIdentifier: "TopBarLayoutViewCell", cellType: TopBarLayoutViewCell.self)) { row, data, cell in
                cell.setData(view: data)
                if (self.initFlag == false) {
                    self.scrollToItem(at: NSIndexPath(item: self.startPage, section: 0) as IndexPath, at: .centeredHorizontally, animated: false)
                    self.initFlag = true
                }
            }
            .disposed(by: disposeBag)
        
        self.nowPage
            .distinctUntilChanged()
            .bind(to: viewModel.pageChanging)
            .disposed(by: disposeBag)
        
        viewModel.slotChanged
            .bind { [weak self] indexPath in
                self?.scrollToItem(at: NSIndexPath(item: indexPath.row, section: 0) as IndexPath, at: .right, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: attribute(), layout() function
    private func attribute() {
        self.delegate = self
        self.isPagingEnabled = true
        self.backgroundColor = .yellow
        self.register(TopBarLayoutViewCell.self, forCellWithReuseIdentifier: "TopBarLayoutViewCell")
    }
    
    private func layout() {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }
}

//MARK: - TabBar: UICollectionViewDelegateFlowLayout
extension TopBarLayoutView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width , height: self.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(floor(scrollView.contentOffset.x / scrollView.frame.width))
        self.nowPage.onNext(page)
    }
}
