//
//  PlayerView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/03.
//

import AVFoundation
import UIKit
/// A view that displays the visual contents of a player object.
class PlayerView: UIView {

    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
