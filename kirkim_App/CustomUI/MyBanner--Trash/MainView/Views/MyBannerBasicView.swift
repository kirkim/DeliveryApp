//
//  MyBannerBasic.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/16.
//

import UIKit

class MyBannerBasicView: UIView {
    var nowPage: Int = 0
    var collectionView: UICollectionView!
    var controlButton: UIButton!
    var totalBannerCount: Int = 0
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
        bannerTimer()
        initControlButton()
    }

    func initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        self.addSubview(self.collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        collectionView.register(MyBannerCell.self, forCellWithReuseIdentifier: "MyBannerCell")
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func initControlButton() {
        self.controlButton = MyBannerTotalButton()
        self.addSubview(self.controlButton)
        self.controlButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(self.collectionView.snp.height).multipliedBy(0.15)
            $0.width.equalTo(self.collectionView.snp.width).multipliedBy(0.2)
        }
        setControlTitle()
        self.controlButton.addTarget(self, action: #selector(handleControlButton), for: .touchUpInside)
    }

    @objc func handleControlButton(_ sender: Any) {
        self.delegate?.handleBannerControlButton()
    }
}

// BannerCollectionView: UICollectionViewDataSource
extension MyBannerBasicView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.model?.getCount() ?? 0
        self.totalBannerCount = count
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBannerCell", for: indexPath) as? MyBannerCell else { return UICollectionViewCell() }
        let image = self.model?.getSmallImageByIndex(index: indexPath.row)
        cell.setData(image: image)
        return cell
    }
}

// BannerCollectionView: UICollectionViewDelegateFlowLayout
extension MyBannerBasicView : UICollectionViewDelegateFlowLayout{
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

// MyBannerView Scroll horizontal & Timer
extension MyBannerBasicView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.setControlTitle()
    }

    func bannerTimer() {
        guard self.totalBannerCount != 0 else { return }
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (Timer) in
            self.bannerMove()
            self.setControlTitle()
                    }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == self.totalBannerCount-1 {
            nowPage = 0
        } else {
            nowPage += 1
        }
        self.collectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }

    func setControlTitle() {
        self.controlButton.setTitle("\(self.nowPage + 1) / \(self.totalBannerCount) 모두보기", for: .normal)
    }
}
