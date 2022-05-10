//
//  MagnetPresentMainTitleCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/01.
//

import UIKit
import SnapKit
import Reusable

class MagnetPresentMainTitleCell: UICollectionViewCell, Reusable {
    private let mainPhotoView = UIImageView()
    private let headerLayer = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(image: UIImage?, title: String, description: String?) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description ?? ""
        mainPhotoView.image = image ?? UIImage(systemName: "x.circle")!
    }
    
    private func attribute() {
        self.backgroundColor = .white
        //Temp
        headerLayer.backgroundColor = .white
        
        
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 23, weight: .medium)
        titleLabel.numberOfLines = 1
        
//        descriptionLabel.text = "초밥 재료는 그날 재료에 따라 달라집니다\n찜&후기약속 꼭 해주세요~~~~"
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        descriptionLabel.numberOfLines = 0

        headerLayer.layer.cornerRadius = 10
        headerLayer.layer.shadowColor = UIColor.black.cgColor
        headerLayer.layer.shadowOffset = CGSize(width: 2, height: 4)
        headerLayer.layer.shadowRadius = 2
        headerLayer.layer.shadowOpacity = 0.5
        headerLayer.layer.masksToBounds = false
    }
    
    private func layout() {
        [mainPhotoView, headerLayer, titleLabel, descriptionLabel].forEach {
            self.addSubview($0)
        }
        
        let windowWidth = MagnetBarViewMath.windowWidth
        
        mainPhotoView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(windowWidth)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainPhotoView.snp.bottom).offset(-30)
            $0.width.equalTo(windowWidth*0.9)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.width.equalTo(windowWidth*0.9)
            $0.centerX.equalToSuperview()
        }
        
        headerLayer.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(-30)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(descriptionLabel).offset(20)
        }
    }
}
