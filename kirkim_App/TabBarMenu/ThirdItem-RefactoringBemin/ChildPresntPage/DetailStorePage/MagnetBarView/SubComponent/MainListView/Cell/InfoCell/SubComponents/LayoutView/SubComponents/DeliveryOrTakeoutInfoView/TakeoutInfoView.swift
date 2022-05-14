//
//  TakeoutInfoView.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import UIKit

class TakeoutInfoView: UIView {
    private let addressLabel = UILabel()
    private let distanceLabel = UILabel()
    private let section1 = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: 나중에 네비 API적용하여 실시간 거리측정한 후 거리텍스트 변경하는식으로 구현
    //TODO: ViewModel에서 주소를 얻어옴
    func setData(address: String) {
        addressLabel.text = address
//        distanceLabel.text = "(주소지로부터 1.7km, 자동차 약 6분)"
    }
    
    private func attribute() {
        self.section1.text = "매장주소"
        
        [section1, addressLabel, distanceLabel].forEach {
            $0.font = .systemFont(ofSize: 16, weight: .light)
            $0.textColor = .black
        }
    }
    
    private func layout() {
        [section1, addressLabel, distanceLabel].forEach {
            self.addSubview($0)
        }
        
        let sectionWidth:CGFloat = 100
        
        section1.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(sectionWidth)
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(section1.snp.trailing)
            $0.top.equalTo(section1)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.leading.equalTo(addressLabel)
            $0.top.equalTo(addressLabel.snp.bottom).offset(5)
        }
    }
}
