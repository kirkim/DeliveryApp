//
//  SideBarHeaderView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Reusable

class SideMenuHeaderView: UITableViewHeaderFooterView, Reusable {
    
    private let disposeBag = DisposeBag()
    
    static let identifier = "SideMenuHeaderView"
    private let user = UserModel()
    
    private var profileView: SimpleProfileView
    private let nameLabel = UILabel()
    private let detailProfileButton = UIButton()
    
    // 중복바인드 방지
    private var flag:Bool = false
    
    override init(reuseIdentifier: String?) {
        profileView = SimpleProfileView(userName: user.info?.data.name ?? "Geust")
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func bind(_ viewModel: SideMenuHeaderViewModel) {
        if (self.flag == false) {
            self.flag = true
            self.detailProfileButton.rx.tap
                .bind(to: viewModel.detailProfileButtonTapped)
                .disposed(by: disposeBag)
        }
    }
    
    private func attribute() {
        contentView.backgroundColor = .systemBrown.withAlphaComponent(0.8)
        nameLabel.text = user.info?.data.name ?? "Geust"
        nameLabel.font = SideMenuSize.labelFont
        nameLabel.textColor = .white
        
        var config = UIButton.Configuration.plain()
        config.buttonSize = .large
        config.image = UIImage(systemName: "chevron.right")
        config.baseForegroundColor = .white
        detailProfileButton.configuration = config

        profileView.layer.cornerRadius = 25
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [profileView, nameLabel, detailProfileButton].forEach {
            contentView.addSubview($0)
        }
        profileView.frame = SideMenuSize.headerImageViewFrame
        
        nameLabel.frame = SideMenuSize.headerLabelFrame
        
        profileView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileView)
            $0.leading.equalTo(profileView.snp.trailing).offset(20)
        }
        
        detailProfileButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
