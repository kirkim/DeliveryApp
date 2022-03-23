//
//  KiflixCollectionCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit

class KiflixCollectionCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(image: UIImage) {
        self.thumbnailView.image = image
    }
}
