//
//  CartWarningMessageCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/17.
//

import UIKit
import Reusable
import SnapKit

class CartWarningMessageCell: UITableViewCell, Reusable {
    private let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: CartWarningMessageItem) {
        self.messageLabel.text = data.message
    }
    
    private func attribute() {
        self.selectionStyle = .none
        self.backgroundColor = .systemGray6
        self.messageLabel.numberOfLines = 0
        self.messageLabel.lineBreakMode = .byCharWrapping
        self.messageLabel.textColor = .systemGray
        self.messageLabel.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    private func layout() {
        self.contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
