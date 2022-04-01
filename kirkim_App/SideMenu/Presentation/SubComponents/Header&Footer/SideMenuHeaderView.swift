//
//  SideBarHeaderView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/21.
//

import UIKit

class SideMenuHeaderView: UITableViewHeaderFooterView {
    static let identifier = "SideMenuHeaderView"
    private let user = UserModel()
    
    private var profileView: SimpleProfileView
    private let nameLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        profileView = SimpleProfileView(userName: user.info?.data.name ?? "Geust")
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func attribute() {
        contentView.backgroundColor = .gray
        nameLabel.text = user.info?.data.name ?? "Geust"
        nameLabel.font = SideMenuSize.labelFont
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [nameLabel, profileView].forEach {
            contentView.addSubview($0)
        }
        nameLabel.frame = SideMenuSize.headerLabelFrame
        profileView.frame = SideMenuSize.headerImageViewFrame
    }
}
