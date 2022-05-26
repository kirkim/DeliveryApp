//
//  DeliveryListPage.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SelectStoreVC: UIViewController {
    private let topBar: TopSlideBar
    private let underline = UIView()
    private let sortBar = SortSlideBar()
    private let disposeBag = DisposeBag()
    private let containerListView: ContainerStoreListView
    private let httpModel = DetailStoreHttpManager.shared
    private let cartButton = ShoppingCartButton()
    
    init(startPage: Int) {
        self.topBar = TopSlideBar(startPage: startPage)
        self.containerListView = ContainerStoreListView(startPage: startPage)
        super.init(nibName: nil, bundle: nil)
        self.title = StoreType.allCases[startPage].title
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func bind(_ viewModel: SelectStoreViewModel) {
        self.topBar.bind(viewModel.topSlideBarViewModel)
        self.sortBar.bind(viewModel.sortSlideBarViewModel)
        self.containerListView.bind(viewModel.containerListViewModel)
        viewModel.changeTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.presentStoreDetailVC
            .emit { storeCode in
                MagnetBarVC.presentView(target: self, type: .basic(storeCode: storeCode))
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
        self.view.backgroundColor = .white
        underline.backgroundColor = .systemGray4
    }
    
    private func layout() {
        [containerListView, topBar, underline, sortBar].forEach {
            self.view.addSubview($0)
        }
        
        topBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        underline.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1) // underline 두깨
        }
        
        sortBar.snp.makeConstraints {
            $0.top.equalTo(underline.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        containerListView.snp.makeConstraints {
            $0.top.equalTo(sortBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        cartButton.addEventAndFrame(vc: self)
    }
}
