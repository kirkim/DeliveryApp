//
//  LoginStatus.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/01.
//

import Foundation

enum LoginStatus {
    case success
    case fail
    var message: String {
        switch self {
        case .success:
            return ""
        case .fail:
            return "아이디 또는 비밀번호를 확인하세요."
        }
    }
}
