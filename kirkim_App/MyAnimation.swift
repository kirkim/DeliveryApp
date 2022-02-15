//
//  MyAnimation.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/15.
//

import UIKit

class MyAnimation {
    static private func shakeTextFieldOneTime(textField: UITextField, withDuration duration: CGFloat, withWidth shakeWidth: CGFloat, completion: ((Bool)->Void)?) {
        UIView.animate(withDuration: duration, animations: {
            textField.frame.origin.x -= shakeWidth
        }, completion: { _ in
            UIView.animate(withDuration: duration, animations: {
                textField.frame.origin.x += (2 * shakeWidth)
            }, completion: { _ in
                UIView.animate(withDuration: duration, animations: {
                    textField.frame.origin.x -= shakeWidth
                }, completion: completion)
            })
        })
    }
    
    static func shakeTextFiled(textField: UITextField, count: Int, withDuration duration: CGFloat, withWidth shakeWidth: CGFloat) -> Void {
        shakeTextFieldOneTime(textField: textField, withDuration: duration, withWidth: shakeWidth, completion: { _ in
            if (count > 0) {
                return shakeTextFiled(textField: textField, count: count - 1, withDuration: duration, withWidth: shakeWidth)
            } else {
                return
            }
        })
    }
}
