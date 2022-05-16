//
//  CartItemCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class CartItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countStepper: CountStepper!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var basePrice: Int = 0
    private var indexPath: IndexPath?
    private let stepperViewModel = CountStepperViewModel()
    private let disposeBag = DisposeBag()
    private let cartManager = CartManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
        bind()
    }

    private func bind() {
        self.countStepper.bind(stepperViewModel)
        stepperViewModel.totalCount
            .bind { value in
                self.priceLabel.text = (self.basePrice * value).parsingToKoreanPrice()
            }
            .disposed(by: disposeBag)
        stepperViewModel.totalCountChanged
            .bind { value in
                if let indexPath = self.indexPath {
                    self.cartManager.changeItemCount(indexPath: indexPath, value: value)
                }
            }
            .disposed(by: disposeBag)
        
        self.deleteButton.rx.tap
            .bind {
                self.cartManager.deleteItem(indexPath: self.indexPath!)
            }
            .disposed(by: disposeBag)
        
        self.titleLabel.rx.tapGesture()
            .when(.recognized)
            .map { _ in self.indexPath! }
            .bind(to: self.cartManager.itemTitleTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.selectionStyle = .none
        
    }
    
    func setData(data: CartMenuItem, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.titleLabel.text = data.title
        self.thumbnailImageView.image = UIImage(data: data.thumbnail)
        self.menuLabel.text = ""
        self.menuLabel.text! = data.menuString.joined(separator: "\n")
        self.basePrice = data.price
        self.stepperViewModel.setCount(count: data.count)
    }
    
}
