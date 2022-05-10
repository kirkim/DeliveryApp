//
//  MyBannerUsingRxSwift.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BeminBannerView: UIView {
    let disposeBag = DisposeBag()
    private let bannerListView: BeminBannerListView
    private let bannerButton = BeminBannerButton()
    private let viewModel: BeminBannerViewModel

    //MARK: - MyBannerUsingRxswift init
    init(data: BannerSources) {
        self.viewModel = BeminBannerViewModel(data: data)
        self.bannerListView = BeminBannerListView(totalPageCount: viewModel.totalPageCount)
        super.init(frame: CGRect.zero)
        self.bind()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - MyBannerUsingRxswift: layout, bind function
    private func layout() {
        [bannerListView, bannerButton].forEach {
            self.addSubview($0)
        }
        
        bannerListView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        
        var buttonWidth = 70
        if (viewModel.bannerButtonType == .event) {
            buttonWidth = 100
        }
        setButtonFrame(frame: CGRect(x: 380 - buttonWidth, y: 150, width: buttonWidth, height: 30))
    }
    
    func setButtonFrame(frame: CGRect) {
        self.bannerButton.frame = frame
        self.bannerButton.layer.cornerRadius = frame.height / 2
    }
    
    private func bind() {
        self.bannerListView.bind(viewModel.bannerListViewModel)
        self.bannerButton.bind(viewModel.buttonViewModel)
        
        self.bannerButton.rx.tap
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
    }
    
    func addTouchEvent(targetViewController: UIViewController) {
        viewModel.presentVC
            .bind { vc in
                targetViewController.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
