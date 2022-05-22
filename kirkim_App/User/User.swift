//
//  User.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
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
