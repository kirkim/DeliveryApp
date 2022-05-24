//
//  ReviewCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
//

import UIKit
import RxGesture
import RxSwift

class ReviewCell: UITableViewCell {
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    private var storeCode: String?
    private var flag:Bool = false
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
    }
    
    func bind(_ viewModel: ReviewCellViewModel) {
        if (self.flag == false) {
            self.flag = true
            self.storeLabel.rx.tapGesture()
                .when(.recognized)
                .map { [weak self] _ -> String in
                    guard let storeCode = self?.storeCode else {
                        return ""
                    }
                    return storeCode
                }
                .bind(to: viewModel.storeLabelTapped)
                .disposed(by: disposeBag)
        }
    }
    
    private func attribute() {
        self.selectionStyle = .none
        storeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        dateLabel.font = .systemFont(ofSize: 15, weight: .medium)
        dateLabel.textColor = .systemGray
    }
    
    func setData(data: ReviewItem, image: UIImage?) {
        self.storeCode = data.storeInfo.storeCode
        self.storeLabel.text = "\(data.storeInfo.storeName) >"
        self.ratingLabel.text = setStar(rating: data.rating)
        self.dateLabel.text = parsingDate(date: data.createAt).description
        self.reviewLabel.text = data.description
        self.reviewLabel.numberOfLines = 0
        if (image != nil) {
            self.photoImageView.image = image
//            photoImageView.contentMode = .scaleAspectFill
            self.imageViewHeightConstraint.constant = self.photoImageView.frame.width
        } else {
            self.imageViewHeightConstraint.constant = 0
        }
    }
    
    private func parsingDate(date: String) -> String {
        let format = ISO8601DateFormatter()
        format.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let parsedDate = format.date(from: date) else { return "" }
        
        let StringFormat = DateFormatter()
        StringFormat.dateFormat = "yyyy년 MM월 dd일"
        return StringFormat.string(for: parsedDate) ?? ""
    }
    
    private func setStar(rating: Int = 5) -> String {
        let totalRating:String = {
            switch rating {
            case 0:
                return "☆☆☆☆☆"
            case 1:
                return "★☆☆☆☆"
            case 2:
                return "★★☆☆☆"
            case 3:
                return "★★★☆☆"
            case 4:
                return "★★★★☆"
            case 5:
                return "★★★★★"
            default:
                return "☆☆☆☆☆"
            }
        }()
        return totalRating
    }
}
