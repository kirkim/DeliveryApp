//
//  String+extension.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import Foundation

extension Int {
    func parsingToKoreanPrice() -> String {
        let frontValue = self / 1000
        let backValue = self % 1000
        
        if (frontValue == 0) {
            return String(backValue) + "원"
        }
        let front = frontValue != 0 ? String(frontValue) + "," : ""
        let back = { () -> String in
            if (backValue < 10) {
                return "00" + String(backValue)
            } else if (backValue < 100) {
                return "0" + String(backValue)
            }
            return String(backValue)
        }()
        return front + back + "원"
    }
}
