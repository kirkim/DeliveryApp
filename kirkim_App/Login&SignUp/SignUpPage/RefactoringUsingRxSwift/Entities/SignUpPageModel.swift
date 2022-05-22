//
//  SignUpPageModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/23.
//

import Foundation

//SignUserData은 Rx버전에서는 사용x
struct SignUserData: Codable {
    var userID: String
    var password: String
    var confirmPassword: String
    var name: String
}

struct CheckId: Codable {
    var userID: String
}
