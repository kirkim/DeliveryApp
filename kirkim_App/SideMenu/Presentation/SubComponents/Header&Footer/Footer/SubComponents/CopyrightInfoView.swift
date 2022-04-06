//
//  CopyrightInfoView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/06.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CopyrightInfoView: UIView {
    private let textLabel = UILabel()
    private let directorButton = UIButton()
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
        directorButton.rx.tap
            .bind(to: buttonTapped)
            .disposed(by: disposeBag)
    }
    
    //attribute, layout
    private func attribute() {
        self.textLabel.text = "Make By"
        
        var config = UIButton.Configuration.plain()
        config.title = "Kirkim"
        config.baseForegroundColor = .brown
        directorButton.configuration = config
    }
    
    private func layout() {
        [textLabel, directorButton].forEach {
            self.addSubview($0)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            
        }
        
        directorButton.snp.makeConstraints {
            $0.top.bottom.equalTo(textLabel)
            $0.leading.equalTo(textLabel.snp.trailing).offset(10)
        }
        
        self.snp.makeConstraints {
            $0.trailing.equalTo(directorButton.snp.trailing)
        }
    }
}
