//
//  ShoppingBasecketVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import SnapKit
import RxSwift

class ShoppingcartVC: UIViewController {
    private let emptyCartView = EmptyCartView()
    private let cartTableView = CartTableView()
    private let cartTypePopupView = CartTypePopupView()
    private let cartSubmitView = CartSubmitView()
    
    private let viewModel = ShoppingcartViewModel()
    
    private let disposeBag = DisposeBag()
    
    //checker
    private var parentNavIsHidden:Bool = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        bind(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.navigationController?.navigationBar.isHidden == true) {
            parentNavIsHidden = true
            self.navigationController?.navigationBar.isHidden = false
        } else {
            parentNavIsHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.parentNavIsHidden == true) {
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func bind(_ viewModel: ShoppingcartViewModel) {
        cartTableView.bind(viewModel.cartTableViewModel)
        cartTypePopupView.bind(viewModel.cartTypePopupViewModel)
        CartManager.shared.getIsValidObserver()
            .bind { [weak self] isValid in
                self?.cartTableView.isHidden = !isValid
                self?.cartSubmitView.isHidden = !isValid
                self?.emptyCartView.isHidden = isValid
            }
            .disposed(by: disposeBag)
        
        viewModel.popupCartTypeView
            .emit { [weak self] type in
                self?.cartTypePopupView.setType(type: type)
                self?.cartTypePopupView.isHidden = false
            }
            .disposed(by: disposeBag)
        
        viewModel.presentStoreVC
            .bind { [weak self] storeCode in
                HttpModel.shared.loadData(code: storeCode) {
                    DispatchQueue.main.async {
                        let vc = MagnetBarView()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.presentDetailMenuVC
            .emit { [weak self] point in
                HttpModel.shared.loadData(code: point.storeCode) {
                    DispatchQueue.main.async {
                        let vc = MagnetBarView()
                        vc.readyToOpenDetailMenuVC(indexPath: point.indexPath)
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        self.title = "장바구니"
        self.cartTypePopupView.isHidden = true
    }
    
    private func layout() {
        [emptyCartView, cartTableView, cartSubmitView, cartTypePopupView].forEach {
            self.view.addSubview($0)
        }
        
        emptyCartView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        cartSubmitView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }

        cartTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(cartSubmitView.snp.top).offset(-10)
        }
                
        cartTypePopupView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
