//
//  SideMenuCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit
import SnapKit

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
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func attribute() {
        self.mainTitle.textColor = .white
        self.thumbnailImageView.tintColor = .white
        self.contentView.backgroundColor = .systemBrown
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [mainTitle, thumbnailImageView].forEach {
            self.contentView.addSubview($0)
        }
        
        let width = contentView.frame.size.height - 15
        
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(width)
            $0.centerY.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
