//
//  MagnetReviewCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/26.
//

import UIKit

class MagnetReviewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
    }
    
    private func attribute() {
        self.selectionStyle = .none
    }
    
    func setData(data: ReviewItem, image: UIImage?) {
        self.nameLabel.text = data.userId
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

