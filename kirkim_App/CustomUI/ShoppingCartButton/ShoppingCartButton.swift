//
//  ShoppingCartButton.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/15.
//

import UIKit
import SnapKit
import RxGesture
import RxCocoa
import RxSwift

class ShoppingCartButton: UIView {
    // UI
    private let imageView = UIImageView()
    private let countLabel = UILabel()
    private let fakeCircle = UIView()
    private let BUTTONSIZE = 80.0
    private let COUNTLABELSIZE = 20.0
    
    private let shoppingcartVC = ShoppingcartVC()
    private let cartManager = CartManager.shared
    
    private let disposeBag = DisposeBag()
    private let buttonClicked = PublishRelay<UITapGestureRecognizer>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        self.rx.tapGesture()
            .when(.recognized)
            .bind(to: buttonClicked)
            .disposed(by: disposeBag)
    }
    
    func addEventAndFrame(vc: UIViewController) {
        self.buttonClicked
            .bind { [weak self] _ in
                if (vc.navigationController != nil) {
                    vc.navigationItem.backButtonTitle = ""
                    vc.navigationController?.pushViewController((self?.shoppingcartVC)!, animated: true)
                } else {
                    vc.present((self?.shoppingcartVC)!, animated: true)
                }
            }
            .disposed(by: disposeBag)
        vc.view.addSubview(self)
        let x = vc.view.frame.width - BUTTONSIZE - 30.0
        let y = vc.view.frame.height - BUTTONSIZE - 70.0
        self.frame = CGRect(x: x, y: y, width: BUTTONSIZE, height: BUTTONSIZE)
    }
    
    private func attribute() {
        self.backgroundColor = .systemMint
        self.layer.cornerRadius = BUTTONSIZE / 2
        
        self.countLabel.backgroundColor = .white
        self.countLabel.textColor = .systemMint
        self.countLabel.textAlignment = .center
        self.countLabel.layer.cornerRadius = COUNTLABELSIZE / 2
        self.countLabel.layer.masksToBounds = true
        
        self.fakeCircle.backgroundColor = .systemMint
        self.fakeCircle.layer.cornerRadius = (COUNTLABELSIZE+4) / 2
        
        self.imageView.image = UIImage(systemName: "cart.fill")
        self.imageView.tintColor = .white
        
        cartManager.getItemCountObserver()
            .map { String($0) }
            .bind(to: self.countLabel.rx.text)
            .disposed(by: disposeBag)
        
        cartManager.getIsValidObserver()
            .bind { isValid in
                self.isHidden = !isValid
            }
            .disposed(by: disposeBag)
    }
    
    private func layout() {
        [imageView, fakeCircle, countLabel].forEach {
            self.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(14)
        }
        
        let padding = BUTTONSIZE / 8
        
        fakeCircle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(padding)
            $0.trailing.equalToSuperview().inset(padding)
            $0.width.height.equalTo(COUNTLABELSIZE+4)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(padding+2)
            $0.trailing.equalToSuperview().inset(padding+2)
            $0.width.height.equalTo(COUNTLABELSIZE)
        }
    }
}
