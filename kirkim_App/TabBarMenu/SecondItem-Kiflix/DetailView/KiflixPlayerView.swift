//
//  PlayerView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/02.
//

import AVFoundation
import UIKit

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

class KiflixPlayerView: PlayerView {
    var playbutton: UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.tintColor = .black
        btn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        btn.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        return btn
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playerUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        playerUI()
    }
    
    private func playerUI() {
        addSubview(playbutton)
        alternativeCustomInit()
    }
    
    func alternativeCustomInit() {
        if let view = Bundle.main.loadNibNamed("KiflixPlayerView", owner: self, options: nil)?.first as? UIView {
                    view.frame = self.bounds
                    addSubview(view)
                }
        }
    
    func setPlayer(player: AVPlayer) {
        self.player = player
    }
    
    func play() {
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
}
