//
//  SideMenuCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit

class SideMenuCell: UITableViewCell {
    private var mainTitle: UILabel = UILabel()
    private var thumbnailImageView = UIImageView()
    private var info: SideMenuViewInfo?
        
    init(info: SideMenuViewInfo) {
        super.init(style: .default, reuseIdentifier: info.identifier)
        self.mainTitle.text = info.mainTitle
        let image = UIImage(systemName: info.thumnailImage ?? "x.circle")
        self.thumbnailImageView = UIImageView(image: image)
        self.info = info
        contentView.addSubview(mainTitle)
        contentView.addSubview(thumbnailImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.frame.size.height - 5
        self.mainTitle.frame = CGRect(x: width + 18, y: 5, width: 100, height: width)
        self.thumbnailImageView.frame = CGRect(x: 8, y: 5, width: width, height: width)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
