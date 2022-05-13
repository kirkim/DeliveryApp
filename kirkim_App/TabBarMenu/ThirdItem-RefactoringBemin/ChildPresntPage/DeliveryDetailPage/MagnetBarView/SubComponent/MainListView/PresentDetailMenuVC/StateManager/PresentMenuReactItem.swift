//
//  PresentMenuReactItem.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/13.
//

import Foundation

struct PresentMenuReactItem {
    var header: String
    let selectType: SelectType
    var items: [PresentMenuItem]
    
    mutating func changeState(row: Int, state: Bool) {
        self.items[row].isSelected = state
    }
    
    mutating func changeAllStateToFalse() {
        for i in 0..<self.items.count {
            self.items[i].isSelected = false
        }
    }
    
    func countOfSelectedItems() -> Int {
        var count = 0
        self.items.forEach { item in
            if (item.isSelected == true) {
                count += 1
            }
        }
        return count
    }
}
