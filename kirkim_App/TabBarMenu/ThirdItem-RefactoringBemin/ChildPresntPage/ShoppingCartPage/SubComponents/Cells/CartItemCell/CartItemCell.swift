//
//  CartItemCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/10.
//

import UIKit
import RxSwift

class CartItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countStepper: CountStepper!
    private var basePrice: Int = 0
    private var indexPath: IndexPath?
//    private var flag:Bool = false
    private let stepperViewModel = CountStepperViewModel()
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
        bind()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    func bind(_ viewModel: CartItemViewModel) {
//        if (flag == false) {
//            flag = true
//
//        }
//    }
    
    private func bind() {
        self.countStepper.bind(stepperViewModel)
        stepperViewModel.totalCount
            .bind { value in
                self.priceLabel.text = (self.basePrice * value).parsingToKoreanPrice()
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.selectionStyle = .none
        
    }
    
    func setData(data: CartMenuItem, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.titleLabel.text = data.title
        self.thumbnailImageView.image = UIImage(systemName: "circle")
        self.menuLabel.text = ""
        data.menuString.forEach { menuString in
            self.menuLabel.text! += menuString + "\n"
        }
        self.basePrice = data.price
        self.stepperViewModel.setCount(count: data.count)
    }
    
}
