//
//  BannerCollectionView.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/08.
//

import UIKit

class BasicBannerView: MyBannerView {
    required init?(coder: NSCoder) {
        super.init(coder: coder, modelType: .basic)
    }
}

class MyBannerView: UIView {
    var nowPage: Int = 0
    var collectionView: UICollectionView!
    var controlButton: UIButton!
    var totalBannerCount: Int = 0
    var delegate: MyBannerViewDelegate?
    var model: BannerImageModel?
        
    init(modelType: BannerImageModel.BannerType) {
        super.init(frame: CGRect.zero)
        self.model = BannerImageModel(type: modelType)
        self.model?.update(completion: {
            DispatchQueue.main.async {
                self.initCollectionView()
                self.collectionView.reloadData()
            }
        })
    }
    
    init?(coder: NSCoder, modelType: BannerImageModel.BannerType) {
        super.init(coder: coder)
        self.model = BannerImageModel(type: modelType)
        self.model?.update(completion: {
            DispatchQueue.main.async {
                self.initCollectionView()
                self.collectionView.reloadData()
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        self.addSubview(self.collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.collectionViewLayout = flowLayout
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func initControlButton() {
        self.controlButton = BannerControlButton()
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
extension MyBannerView: UICollectionViewDataSource {
    // 섹션의 갯수가 정해질 때 정확한 수치를 얻을 수 있다. 그래서 컨트롤버튼과 타이머를 이곳에서 초기화해주었다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.model?.getCount() ?? 0
        self.totalBannerCount = count
        self.initControlButton()
        self.bannerTimer()
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else { return UICollectionViewCell() }
            let image = self.model?.getImageByIndex(index: indexPath.row)
            cell.setData(image: image)
        return cell
    }
}

// BannerCollectionView: UICollectionViewDelegateFlowLayout
extension MyBannerView : UICollectionViewDelegateFlowLayout{
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
extension MyBannerView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.setControlTitle()
    }
    
    func bannerTimer() {
        guard self.totalBannerCount != 0 else { return }
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
            self.setControlTitle()
                    }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == self.totalBannerCount-1 {
            // 맨 처음 페이지로 돌아감
            self.collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        self.collectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    func setControlTitle() {
        self.controlButton.setTitle("\(self.nowPage + 1) / \(self.totalBannerCount) 모두보기", for: .normal)

    }
}
