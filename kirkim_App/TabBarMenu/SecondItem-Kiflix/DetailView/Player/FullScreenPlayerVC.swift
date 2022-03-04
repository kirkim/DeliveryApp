//
//  FullScreenPlayer.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/03.
//

import UIKit
import AVFoundation

class FullScreenPlayerVC: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playButton: UIButton!
    
    let player = KiflixPlayer.shared
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.player = player
        
        toggleButtonUI()
    }
    
    func toggleButtonUI() {
        if (player.isPlaying) {
            self.playButton.isSelected = true
        } else {
            self.playButton.isSelected = false
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func handlePlayButton(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        toggleButtonUI()
    }
}
