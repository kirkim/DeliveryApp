//
//  OpenProfileButton.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/06.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class DetailProfileButton: UIButton {
    private let disposeBag = DisposeBag()
    // View -> ParentView
    let buttonTapped = PublishRelay<Void>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        self.rx.tap
            .bind(to: self.buttonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .large
        config.image = UIImage(systemName: "chevron.right")
        config.baseForegroundColor = .brown
        self.configuration = config
    }
}
