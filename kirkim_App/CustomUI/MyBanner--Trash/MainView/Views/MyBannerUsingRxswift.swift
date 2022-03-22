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
    var nowPageSubject = BehaviorSubject<Int>(value: 0)
    var collectionView: UICollectionView!
    var controlButton: UIButton!
    var totalBannerCount: Int = 0
    weak var timer: Timer?
    var delegate: MyBannerViewDelegate?
    var model: MyBannerByPlistViewModel?

//MARK: - MyBannerUsingRxswift init
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
    
//MARK: - MyBannerUsingRxswift custom init
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

//MARK: - MyBannerUsingRxswift UICollectionViewDelegateFlowLayout
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

//MARK: - MyBannerUsingRxswift UICollectionViewDelegate
extension MyBannerUsingRxswift: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedBannerView(indexPath: indexPath)
    }
}

//MARK: - MyBannerUsingRxswift UICollectionViewDataSource
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

//MARK: - MyBannerUsingRxswift about Moving Banner Slide
extension MyBannerUsingRxswift {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        nowPageSubject.onNext(page)
    }
    
    func initTimer() {
        guard self.totalBannerCount != 0 else { return }
        bannerTimer(period: 3)
        updateButtonTitle()
    }
    
    func bannerTimer(period: Int) {
        Observable<Int>
            .interval(.seconds(period), scheduler: MainScheduler.instance)
            .withLatestFrom(nowPageSubject) {
                return (1 + $1) % self.totalBannerCount
            }
            .subscribe(onNext: { [weak self] page in
                self?.nowPageSubject.onNext(page)
                self?.collectionView.scrollToItem(at: NSIndexPath(item: page, section: 0) as IndexPath, at: .right, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func updateButtonTitle() {
        nowPageSubject
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] page in
                guard let self = self else { return }
                self.controlButton.setTitle("\(page + 1) / \(self.totalBannerCount) 모두보기", for: .normal)
            })
            .disposed(by: disposeBag)
    }
}
