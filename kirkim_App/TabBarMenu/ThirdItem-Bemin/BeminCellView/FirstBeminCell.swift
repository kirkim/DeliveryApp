//
//  FirstBeminCell.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/07.
//

import UIKit
import SnapKit

class FirstBeminCell: UIView {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .red
    }
    
}

//MARK: - Preview
import SwiftUI

struct MyYellowButtonPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = FirstBeminCell()
            return view
        }.previewLayout(.sizeThatFits)
    }
}
