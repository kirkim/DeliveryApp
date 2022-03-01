//
//  MainBannerView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/23.
//

import FSPagerView

final class BannerView: UIView, FSPagerViewDelegate, FSPagerViewDataSource {
    private let bannerImageModel = BannerImageModel()
    var pagerView: FSPagerView?
    var pageController: FSPageControl?
    
    override var frame: CGRect {
        didSet {
            bannerImageModel.update {
                DispatchQueue.main.async {
                    self.pagerView = self.madeFSPagerView()
                    self.pageController = self.madeFSPageControl()
                    self.addSubview(self.pagerView!)
                    self.addSubview(self.pageController!)
                }
            }
        }
    }
    
    private func madeFSPagerView() -> FSPagerView {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let pagerV = FSPagerView(frame: frame)
        pagerV.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerV.itemSize = FSPagerView.automaticSize
        pagerV.isInfinite = true
        pagerV.automaticSlidingInterval = 4.0
        pagerV.delegate = self
        pagerV.dataSource = self
        return pagerV
    }
    
    private func madeFSPageControl() -> FSPageControl {
        let count: Int = self.bannerImageModel.getCount()
        let size: CGFloat = 10
        let spacing: CGFloat = 16
        let width: CGFloat = CGFloat(count) * (size + spacing)
        let x: CGFloat = self.frame.width - width
        let height: CGFloat = 40
        let y: CGFloat = self.frame.height - height
        let pageC = FSPageControl(frame: CGRect(x:x, y: y, width: width, height: height))
        pageC.contentHorizontalAlignment = .left
        pageC.itemSpacing = size
        pageC.interitemSpacing = spacing
        pageC.numberOfPages = self.bannerImageModel.getCount()
        return pageC
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: -
extension BannerView {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerImageModel.getCount()
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = self.bannerImageModel.getImageByIndex(index: index)
        
            return cell
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageController?.currentPage = self.pagerView!.currentIndex
    }
}
