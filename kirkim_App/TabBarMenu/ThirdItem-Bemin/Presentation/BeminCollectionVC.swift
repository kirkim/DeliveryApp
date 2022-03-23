//
//  BeminCollectionVC.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/09.
//

import UIKit

class BeminVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        let beminCollectionVC = BeminCollectionVC()
        addChild(beminCollectionVC)
        beminCollectionVC.collectionView.frame = view.frame
        view.addSubview(beminCollectionVC.collectionView)
        beminCollectionVC.didMove(toParent: self)
    }
}

class BeminCollectionVC: UICollectionViewController {
    private let STATIC_SECTION_TOTALCOUNT: Int
    private let staticModel = StaticSectionViewModel()
    
//MARK: - BeminCollectionVC init
    init() {
        let layout = UICollectionViewLayout()
        self.STATIC_SECTION_TOTALCOUNT = staticModel.getStaticSectionTotalCount()
        super.init(collectionViewLayout: layout)
        staticModel.registerCells(on: collectionView)
        collectionView.collectionViewLayout = createLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - BeminCollectionVC: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = "xxxx xxxx"
    }

 //MARK: - BeminCollectionVC: bind
    private func bind() {
//        let bannerViewModel = RxBannerViewModel(plistType: .staticEvent)
        staticModel.getBannerView().bind(RxBannerViewModel(plistType: .staticEvent), parentViewController: self)
    }
    
    
//MARK: - BeminCollectionVC custom function
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if (sectionNumber < self.STATIC_SECTION_TOTALCOUNT) {
                return self.staticModel.staticSectionLayout(sectionNumber: sectionNumber)
            } else {
                return self.staticModel.staticSectionLayout(sectionNumber: sectionNumber)
            }
        }
    }
}

//MARK: - BeminCollectionVC: StaticBanner delegate
extension BeminCollectionVC: MyBannerViewDelegate {
    func handleBannerControlButton() {
        print("BeminCollectionVC button")
    }
    
    func didSelectedBannerView(indexPath: IndexPath) {
        print("BeminCollectionVC index: \(indexPath.row)")
    }
}

//MARK: - BeminCollectionVC: collectionView datasource function
extension BeminCollectionVC {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.STATIC_SECTION_TOTALCOUNT
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section < self.STATIC_SECTION_TOTALCOUNT) {
            return staticModel.numberOfStaticItem(section: section)
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section < self.STATIC_SECTION_TOTALCOUNT) {
            return staticModel.getCellBySection(collectionView, cellForItemAt: indexPath)
        } else {
            return UICollectionViewCell()
        }
    }
}

//MARK: - BeminCollectionVC: delegate function
extension BeminCollectionVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 5) {
            print("here")
        } else {
            print("hummm")
        }
    }
}

import SwiftUI

struct BeminCollectionVC_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: BeminCollectionVC())
        }
        typealias UIViewControllerType = UIViewController
    }
}
