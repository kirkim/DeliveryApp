//
//  BottomBarItem.swift
//  TopBarVC
//
//  Created by 김기림 on 2022/04/09.
//

import UIKit

struct BottomBarItems {
    var presentVC: BottomBarPresentVC
    var datas: BottomBarDatas
}

struct BottomBarPresentVC {
    var button1: UIViewController
    var button2: UIViewController
    var button3: UIViewController
    var button4: UIViewController
}

struct BottomBarDatas {
    var button1: BottomButtonData
    var button2: BottomButtonData
    var button3: BottomButtonData
    var button4: BottomButtonData
}

struct BottomButtonData {
    var image: UIImage = UIImage(systemName: "circle")!
    var title: String
    var tintColor: UIColor = .darkGray
    var backgroundColor: UIColor = .white
}
