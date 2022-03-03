//
//  KiflixPlayer.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/03.
//

import AVFoundation

class KiflixPlayer: AVPlayer {
    static let shared = KiflixPlayer()
    private override init() {
        super.init()
    }
}
