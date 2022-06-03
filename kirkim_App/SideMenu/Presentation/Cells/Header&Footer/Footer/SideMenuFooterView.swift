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
import Reusable

class SideMenuFooterView: UITableViewHeaderFooterView, Reusable {
    static let identifier = "SideMenuFooterView"
    private let logoutView = LogoutView()
    private let copyrightInfoView = CopyrightInfoView()
    private let disposeBag = DisposeBag()
    private var flag:Bool = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SideMenuFooterViewModel) {
        if (self.flag == false) {
            self.flag = true
            self.logoutView.buttonTapped
                .bind(to: viewModel.logoutButtonTapped)
                .disposed(by: disposeBag)
            
            self.copyrightInfoView.buttonTapped
                .bind(to: viewModel.copyrightButtonTapped)
                .disposed(by: disposeBag)
            
        }
    }
    
    private func attribute() {
        contentView.backgroundColor = .clear
    }
    
    private func layout() {
        [logoutView, copyrightInfoView].forEach {
            contentView.addSubview($0)
        }
        
        logoutView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(contentView)
        }
        
        copyrightInfoView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoutView.snp.bottom)
        }
    }
}
