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

class SideMenuHeaderView: UITableViewHeaderFooterView {
    
    private let disposeBag = DisposeBag()
    //View -> ParentView
    let detailProfileButtonTapped = PublishRelay<Void>()
    
    static let identifier = "SideMenuHeaderView"
    private let user = UserModel()
    
    private var profileView: SimpleProfileView
    private let nameLabel = UILabel()
    private let detailProfileButton = DetailProfileButton()
    
    override init(reuseIdentifier: String?) {
        profileView = SimpleProfileView(userName: user.info?.data.name ?? "Geust")
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func bind() {
        self.detailProfileButton.buttonTapped
            .bind(to: self.detailProfileButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        contentView.backgroundColor = .systemGray5
        nameLabel.text = user.info?.data.name ?? "Geust"
        nameLabel.font = SideMenuSize.labelFont
        
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
