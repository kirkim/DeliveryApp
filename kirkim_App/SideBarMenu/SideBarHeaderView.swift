//
//  SideBarHeaderView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/21.
//

import UIKit

class SideBarHeaderView: UITableViewHeaderFooterView {
    static let identifier = "SideBarHeaderView"
    private let user = LoginUserModel.shared.user
    
    private let profileView: SimpleProfileView = {
        let profileView = SimpleProfileView(userName: LoginUserModel.shared.user?.data.name ?? "Geust")
        return profileView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = LoginUserModel.shared.user?.data.name ?? "Geust"
        label.font = SideMenuSize.labelFont
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(profileView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = SideMenuSize.headerLabelFrame
        profileView.frame = SideMenuSize.headerImageViewFrame
    }
}
