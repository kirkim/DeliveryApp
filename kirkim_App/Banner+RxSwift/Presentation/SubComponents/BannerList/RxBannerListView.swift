//
//  RxBannerCollectionView.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class RxBannerListView: UICollectionView {
    let disposeBag = DisposeBag()
    var timer: Disposable?
    let nowPage = BehaviorSubject<Int>(value: 0)
    
    //MARK: RxBannerCollectionView: init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
        self.register(RxBannerCell.self, forCellWithReuseIdentifier: "RxBannerCell")
        self.isPagingEnabled = true
        self.delegate = self
    }
    
    private func layout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionViewLayout = flowLayout
    }
    
    func bind(_ viewModel: RxBannerListViewModel) {
        viewModel.cellImageName
            .drive(self.rx.items) { cv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "RxBannerCell", for: index) as! RxBannerCell
                cell.setData(imageName: data)
                return cell
            }
            .disposed(by: disposeBag)
        
        self.nowPage
            .bind(to: viewModel.nowPage)
            .disposed(by: disposeBag)
    }
}

//MARK: - RxBannerCollectionView: UICollectionViewDelegateFlowLayout
extension RxBannerListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        let height = self.frame.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - RxBannerCollectionView: Function about banner moving
extension RxBannerListView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print(page)
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
                return (1 + $1) % 4
            }
            .subscribe(onNext: { [weak self] page in
                self?.nowPage.onNext(page)
                self?.scrollToItem(at: NSIndexPath(item: page, section: 0) as IndexPath, at: .right, animated: true)
            })
    }
}
