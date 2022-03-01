//
//  KeyboardAnimation.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import UIKit

class KeyboardAnimation {
    static public func dismissKeyboardBytouchBackground(view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
}
