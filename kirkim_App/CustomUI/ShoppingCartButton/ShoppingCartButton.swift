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

enum DetailStoreType {
    case basic(storeCode: String)
    case fake(point: PresentDetailMenuPoint)
}

class ShoppingCartButton: UIView {
    // UI
    private let imageView = UIImageView()
    private let countLabel = UILabel()
    private let fakeCircle = UIView()
    private let BUTTONSIZE = 80.0
    private let COUNTLABELSIZE = 20.0
    
    private let cartManager = CartManager.shared
    
    private let disposeBag = DisposeBag()
    private let buttonClicked = PublishRelay<UITapGestureRecognizer>()
    
    private let detailStoreType: DetailStoreType
    
    init(type: DetailStoreType = .basic(storeCode: DetailStoreHttpManager.shared.getStoreCode())) {
        self.detailStoreType = type
        super.init(frame: CGRect.zero)
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
    
    func addEventAndFrame(vc: UIViewController) {
        self.buttonClicked
            .bind { [weak self] _ in
                switch self?.detailStoreType {
                case .fake(point: _):
                    vc.navigationController?.popViewController(animated: true)
                    return
                default:
                    break;
                }
                let shoppingcartVC = ShoppingcartVC()
                if (vc.navigationController != nil) {
                    vc.navigationItem.backButtonTitle = ""
                    vc.navigationController?.pushViewController(shoppingcartVC, animated: true)
                } else {
                    vc.present(shoppingcartVC, animated: true)
                }
            }
            .disposed(by: disposeBag)
        vc.view.addSubview(self)
        let x = vc.view.frame.width - BUTTONSIZE - 20.0
        let y = vc.view.frame.height - BUTTONSIZE - 70.0
        self.frame = CGRect(x: x, y: y, width: BUTTONSIZE, height: BUTTONSIZE)
    }
    
    private func attribute() {
        self.backgroundColor = .systemBrown
        self.layer.cornerRadius = BUTTONSIZE / 2
        
        self.countLabel.backgroundColor = .white
        self.countLabel.textColor = .systemBrown
        self.countLabel.textAlignment = .center
        self.countLabel.layer.cornerRadius = COUNTLABELSIZE / 2
        self.countLabel.layer.masksToBounds = true
        
        self.fakeCircle.backgroundColor = .systemBrown
        self.fakeCircle.layer.cornerRadius = (COUNTLABELSIZE+4) / 2
        
        self.imageView.image = UIImage(systemName: "cart.fill")
        self.imageView.tintColor = .white
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
    }
    
    private func layout() {
        [imageView, fakeCircle, countLabel].forEach {
            self.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        let padding = BUTTONSIZE / 7
        
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
