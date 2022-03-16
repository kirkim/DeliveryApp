//
//  MyBannerByPlistView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import UIKit
import SnapKit

// coder를 이용해서 Basic배너뷰를 초기화했을 때용 => coder로 초기화시 인자를 주기힘들기 때문
// 배너뷰의 type이 늘어나면 이와같은 클래스를 추가로 만들어 줘야함.
//class BasicBannerView: MyBannerByAPIView {
//    required init?(coder: NSCoder) {
//        super.init(coder: coder, modelType: .basic)
//    }
//}

class MyBannerByPlistView: UIView {
    var nowPage: Int = 0
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
        bannerTimer()
        initControlButton()
    }
    
    private func initCollectionView() {
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: createLayout())
        self.addSubview(self.collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        collectionView.register(MyBannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.visibleItemsInvalidationHandler = { (visibleItems, point, env) -> Void in
                self.nowPage = Int(point.x) / Int(self.collectionView.frame.width)
                self.setControlTitle()
            }
            return section
        }
    }
    
    private func initControlButton() {
        self.controlButton = MyBannerTotalButton()
        self.addSubview(self.controlButton)
        self.controlButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(self.collectionView.snp.height).multipliedBy(0.15)
            $0.width.equalTo(self.collectionView.snp.width).multipliedBy(0.25)
        }
        setControlTitle()
        self.controlButton.addTarget(self, action: #selector(handleControlButton), for: .touchUpInside)
    }
    
    @objc func handleControlButton(_ sender: Any) {
        self.delegate?.handleBannerControlButton()
    }
}

extension MyBannerByPlistView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedBannerView(indexPath: indexPath)
    }
}

// BannerCollectionView: UICollectionViewDataSource
extension MyBannerByPlistView: UICollectionViewDataSource {
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
extension MyBannerByPlistView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.setControlTitle()
    }
    
    func bannerTimer() {
        guard self.totalBannerCount != 0 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (Timer) in
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

