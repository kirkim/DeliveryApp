//
//  ReviewHeaderView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/23.
//

import UIKit
import Reusable

class ReviewHeaderView: UITableViewHeaderFooterView, Reusable {
    private let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        
    }
}
