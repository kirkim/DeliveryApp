//
//  DetailProfileVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/06.
//

import UIKit

class DetailProfileVC: UIViewController {
    let titleLabel = UILabel()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        
    }
    
    // attribute, layout
    private func attribute() {
        self.view.backgroundColor = .white
        self.titleLabel.text = "Detail Profile View"
        self.titleLabel.textColor = .green
        self.titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    private func layout() {
        [titleLabel].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(70)
        }
    }
}
