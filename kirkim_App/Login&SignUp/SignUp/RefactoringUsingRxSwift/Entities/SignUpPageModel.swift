//
//  SignUpPageModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/23.
//

import Foundation

struct User: Codable {
    var data: UserData
    var id: String
}

struct UserData: Codable {
    var userID: String
    var password: String
    var name: String
}

struct SignupUser: Codable {
    var userID: String
    var password: String
    var confirmPassword: String
    var name: String
}

struct CheckId: Codable {
    var userID: String
}
