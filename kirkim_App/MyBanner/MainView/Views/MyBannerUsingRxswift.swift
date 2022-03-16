//
//  MyBannerUsingRxSwift.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/16.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class MyBannerUsingRxswift: UIView {
    let disposeBag = DisposeBag()
    var dragPage: Int = 0
    var nowPage = BehaviorSubject<Int>(value: 0)
    var collectionView: UICollectionView!
    var controlButton: UIButton!
    var totalBannerCount: Int = 0
    weak var timer: Timer?
    var delegate: MyBannerViewDelegate?
    var model: MyBannerByPlistViewModel?
        
    init(modelType: MyBannerByPlistViewModel.BannerType) {
        super.init(frame: CGRect.zero)
        self.model = MyBannerByPlistViewModel(type: modelType)
        bannerInit()
    }
    
    init?(coder: NSCoder, modelType: MyBannerByPlistViewModel.BannerType) {
        super.init(coder: coder)
        self.model = MyBannerByPlistViewModel(type: modelType)
        bannerInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func bannerInit() {
        self.totalBannerCount = self.model?.getCount() ?? 0
        initCollectionView()
        initTimer()
        initControlButton()
    }
    
    private func initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        self.addSubview(self.collectionView)
        collectionView.isPagingEnabled = true
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        collectionView.register(MyBannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func initControlButton() {
        self.controlButton = MyBannerTotalButton()
        self.addSubview(self.controlButton)
        self.controlButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(self.collectionView.snp.height).multipliedBy(0.15)
            $0.width.equalTo(self.collectionView.snp.width).multipliedBy(0.25)
        }
        self.controlButton.addTarget(self, action: #selector(handleControlButton), for: .touchUpInside)
    }
    
    @objc func handleControlButton(_ sender: Any) {
        self.delegate?.handleBannerControlButton()
    }
}

extension MyBannerUsingRxswift : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width
        let height = self.collectionView.frame.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MyBannerUsingRxswift: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedBannerView(indexPath: indexPath)
    }
}

// BannerCollectionView: UICollectionViewDataSource
extension MyBannerUsingRxswift: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.model?.getCount() ?? 0
        self.totalBannerCount = count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? MyBannerCell else { return UICollectionViewCell() }
            let image = self.model?.getSmallImageByIndex(index: indexPath.row)
            cell.setData(image: image)
        return cell
    }
}

// MyBannerView Scroll horizontal & Timer
extension MyBannerUsingRxswift {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.dragPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        nowPage.onNext(self.dragPage)
    }
    
    func initTimer() {
        guard self.totalBannerCount != 0 else { return }
        bannerTimer()
        bannerMove()
    }
    
    func bannerTimer() {
        Observable<Int>
            .interval(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.dragPage = self.dragPage == self.totalBannerCount-1 ? 0 : self.dragPage+1
                self.collectionView.scrollToItem(at: NSIndexPath(item: self.dragPage, section: 0) as IndexPath, at: .right, animated: true)
                self.nowPage.onNext(self.dragPage)
            })
            .disposed(by: disposeBag)
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        nowPage
            .subscribe(onNext: { [weak self] page in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.controlButton.setTitle("\(page + 1) / \(self.totalBannerCount) 모두보기", for: .normal)
            }
        })
        .disposed(by: disposeBag)
    }
}
