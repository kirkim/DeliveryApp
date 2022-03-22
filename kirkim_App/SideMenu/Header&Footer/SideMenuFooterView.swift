//
//  SideMenuFooterView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/22.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class SideMenuFooterView: UITableViewHeaderFooterView {
    static let identifier = "SideMenuFooterView"
    private let logoutButton = UIButton()
    private let makerButton = UIButton()
    private let disposeBag = DisposeBag()
    let logoutButtonTapped = PublishRelay<Void>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
        bind()
        contentView.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [logoutButton, makerButton].forEach {
            contentView.addSubview($0)
        }
        
        logoutButton.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(contentView)
            $0.height.equalTo(50)
        }
        
        makerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoutButton.snp.bottom).offset(10)
        }
    }
    
    private func bind() {
        logoutButton.rx.tap
            .bind(to: logoutButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        logoutButton.backgroundColor = .blue
        makerButton.backgroundColor = .purple
        
        logoutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        logoutButton.setTitle(" 로그아웃", for: .normal)
        logoutButton.contentHorizontalAlignment = .leading
        logoutButton.configuration?.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 0)
        
        makerButton.setTitle("Make By Kirkim", for: .normal)
    }
}
