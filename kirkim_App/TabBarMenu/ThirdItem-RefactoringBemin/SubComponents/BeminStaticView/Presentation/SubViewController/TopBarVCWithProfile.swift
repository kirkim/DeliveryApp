//
//  TopBarVCWithProfile.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit

class TopBarVCWithProfile: BaseVC {
    private let deliveryListVC = DeliveryMenuVC()
    private let deliveryListViewModel = DeliveryMenuViewModel()
    private let viewModel: TopBarMainViewModel
    private let startPage: Int
    
    init(startPage: Int) {
        self.startPage = startPage
        
        self.viewModel = TopBarMainViewModel(
            topBarItems: [
                TopBarItem(viewController: deliveryListVC, itemTitle: "배민1"),
                TopBarItem(viewController: Test2(), itemTitle: "배달"),
                TopBarItem(viewController: Test3(), itemTitle: "포장"),
                TopBarItem(viewController: Test1(), itemTitle: "B마트"),
                TopBarItem(viewController: Test3(), itemTitle: "간편식/밀키트"),
                TopBarItem(viewController: Test2(), itemTitle: "배민스토어"),
                TopBarItem(viewController: Test3(), itemTitle: "쇼핑라이브"),
                TopBarItem(viewController: Test1(), itemTitle: "선물하기"),
                TopBarItem(viewController: Test2(), itemTitle: "전국별미"),
            ],
            bottomBarItem: BottomBarItem(
                presentVC1: ButtonVC1(),
                presentVC2: ButtonVC2(),
                presentVC3: ButtonVC3(),
                presentVC4: ButtonVC4()
            )
        )
//        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        deliveryListVC.bind(deliveryListViewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let beminCollectionVC = TopBarMainViewController(startPage: self.startPage)
        beminCollectionVC.bind(viewModel)
        addChild(beminCollectionVC)
        beminCollectionVC.view.frame = view.frame
        view.addSubview(beminCollectionVC.view)
        beminCollectionVC.didMove(toParent: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "배민"
    }
}

