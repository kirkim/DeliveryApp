//
//  SeeMyReviewView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/25.
//

import UIKit

class SeeMyReviewView: BasicReviewVC, SideMenuViewProtocol {
    static var sideMenuViewInfo = SideMenuViewInfo(thumnailImage: "rectangle.and.pencil.and.ellipsis", mainTitle: "내 리뷰 보기", section: .one, identifier: "SeeMyReviewView")
    
    init() {
        super.init(type: .me(userInfo: UserInfo(userID: "", name: "", id: (UserModel().info?.id)!)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
