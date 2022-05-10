//
//  MagnetBarView.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/12.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable

struct MagnetBarViewMath {
    static let windowWidth:CGFloat = (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).windowWidth!
    static let navigationHeight:CGFloat = 80
    static let stickyHeaderHeight:CGFloat = 70
    static let naviTitleFontSize:CGFloat = 20
    static let naviTitleBottomMargin:CGFloat = 5
    static let naviTitleLeftMargin:CGFloat = 50
    static let headerViewHeight:CGFloat = 150
}

typealias HttpModel = MagnetBarHttpModel
class MagnetBarView: UIViewController {
    private let mainListView = MagnetListView()
    private let mainNavigationBar = MagnetNavigationBar()
    private let stickyHeader = RemoteMainListBar()
    
    private let viewModel = MagnetBarViewModel()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func bind() {
        mainNavigationBar.bind(viewModel.mainNavigationBarViewModel)
        mainListView.bind(viewModel.mainListViewModel)
        stickyHeader.bind(viewModel.stickyHeaderViewModel)
        
        viewModel.presentReviewVC
            .emit { vc in
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.presentMenuVC
            .emit { vc in
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.stickyHeaderOn
            .emit { isOn in
                if (isOn == true){
                    self.stickyHeader.isUserInteractionEnabled = true
                    self.stickyHeader.alpha = 1
                } else {
                    self.stickyHeader.isUserInteractionEnabled = false
                    self.stickyHeader.alpha = 0
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.backButtonTapped
            .emit(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.navigationItem.backButtonTitle = ""
        mainNavigationBar.layer.shadowColor = UIColor.black.cgColor
        mainNavigationBar.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        mainNavigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainNavigationBar.layer.shadowRadius = 1
        mainNavigationBar.layer.shadowOpacity = 0.2
        
        self.stickyHeader.isUserInteractionEnabled = false
        self.stickyHeader.alpha = 0
    }
    
    private func layout() {
        [mainListView, mainNavigationBar, stickyHeader].forEach {
            self.view.addSubview($0)
        }
        
        mainListView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mainNavigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(MagnetBarViewMath.navigationHeight)
        }
        
        stickyHeader.snp.makeConstraints {
            $0.top.equalTo(mainNavigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(MagnetBarViewMath.stickyHeaderHeight)
        }
    }
}
