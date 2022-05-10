//
//  RxBannerCollectionView.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class BeminBannerListView: UICollectionView {
    private let disposeBag = DisposeBag()
    private var timer: Disposable?
    private let nowPage = BehaviorSubject<Int>(value: 0)
    private let totalPageCount: Int
    
    //MARK: RxBannerCollectionView: init
    init(totalPageCount: Int) {
        self.totalPageCount = totalPageCount
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.attribute()
        self.layout()
        self.startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.dispose()
    }
    
    //MARK: - RxBannerCollectionView: attribute, layout, bind function
    private func attribute() {
        self.register(BeminBannerCell.self, forCellWithReuseIdentifier: "BeminBannerCell")
        self.isPagingEnabled = true
        self.delegate = self
    }
    
    private func layout() {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }
    
    func bind(_ viewModel: BeminBannerListViewModel) {
        viewModel.cellImageName
            .drive(self.rx.items(cellIdentifier: "BeminBannerCell", cellType: BeminBannerCell.self)) { row, data, cell in
                cell.setData(imageData: data)
            }
            .disposed(by: disposeBag)
        
        self.nowPage
            .bind(to: viewModel.nowPage)
            .disposed(by: disposeBag)
        
        self.rx.itemSelected
            .distinctUntilChanged()
            .bind(to: viewModel.cellClicked)
            .disposed(by: disposeBag)
    }
}

//MARK: - RxBannerCollectionView: UICollectionViewDelegateFlowLayout
extension BeminBannerListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        let height = self.frame.height
        return CGSize(width: width, height: height)
    }
}

//MARK: - RxBannerCollectionView: Function about banner moving
extension BeminBannerListView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        nowPage.onNext(page)
        startTimer()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.dispose()
    }
    
    func startTimer(period: Int = 3) {
        self.timer?.dispose()
        self.timer = Observable<Int>
            .interval(.seconds(period), scheduler: MainScheduler.instance)
            .withLatestFrom(nowPage) {
                return (1 + $1) % self.totalPageCount
            }
            .subscribe(onNext: { [weak self] page in
                self?.nowPage.onNext(page)
                self?.scrollToItem(at: NSIndexPath(item: page, section: 0) as IndexPath, at: .right, animated: true)
            })
    }
}
