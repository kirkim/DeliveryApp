//
//  SimpleProfileView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/21.
//

import UIKit

class SimpleProfileView: UIButton {
    private var firstLetter: String?
    
    init(userName: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        self.firstLetter = String(userName[userName.startIndex])
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        self.backgroundColor = .blue
        self.setTitle(self.firstLetter, for: .normal)
        self.tintColor = .white
    }
}
