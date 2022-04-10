//
//  TabBarMain.swift
//  CustomTabBar
//
//  Created by 김기림 on 2022/04/07.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class TopBarMainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let layoutView: TopBarLayoutView
    private let topBar: TopBar
    private var bottomBar = BottomBar()
    
    init(startPage: Int = 0) {
        self.layoutView = TopBarLayoutView(startPage: startPage)
        self.topBar = TopBar(startPage: startPage)
        super.init(nibName: nil, bundle: nil)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TopBarMainViewModel) {
        viewModel.subViewControllers.forEach {
            self.addChild($0)
            $0.didMove(toParent: self)
        }
 
        self.layoutView.bind(viewModel.layoutViewModel)
        self.topBar.bind(viewModel.topBarViewModel)
        self.bottomBar.bind(viewModel.bottomBarViewModel)
        
        viewModel.presentVC
            .emit { [weak self] vc in
                self?.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.dismissVC
            .emit { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: attribute(), layout() function
    private func attribute() {
        self.view.backgroundColor = .systemMint
    }
    
    private func layout() {
        [topBar, layoutView].forEach {
            self.view.addSubview($0)
        }
        
        topBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        layoutView.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view.addSubview(bottomBar)
        bottomBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
}
