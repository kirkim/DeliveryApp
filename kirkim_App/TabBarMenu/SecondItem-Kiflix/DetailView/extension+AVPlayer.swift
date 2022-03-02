//
//  extension+AVPlayer.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/02.
//

import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
