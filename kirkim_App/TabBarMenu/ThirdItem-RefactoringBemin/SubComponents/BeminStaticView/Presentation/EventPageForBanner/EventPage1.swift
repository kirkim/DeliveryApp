//
//  EventPage1.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/23.
//

import UIKit

class EventPage1: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.view.backgroundColor = .blue
    }
    
    private func layout() {
        
    }
}
