//
//  LogoutView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/06.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class LogoutView: UIView {
    private let logoutButton = UIButton()
    private let disposeBag = DisposeBag()
    
    // View -> ParentView(SideMenuFooterView)
    let buttonTapped = PublishRelay<Void>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //bind
    private func bind() {
        logoutButton.rx.tap
            .bind(to: buttonTapped)
            .disposed(by: disposeBag)
    }
    
    //attribute, layout
    private func attribute() {
        self.backgroundColor = .systemGray5
        var config = UIButton.Configuration.plain()
        config.title = " 로그아웃"
        config.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        config.baseForegroundColor = .brown
        logoutButton.configuration = config
    }
    
    private func layout() {
        self.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(10)
        }
    }
}
