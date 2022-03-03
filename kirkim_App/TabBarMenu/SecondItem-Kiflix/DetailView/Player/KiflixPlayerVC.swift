//
//  KiflixPlayerVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/03.
//

import AVFoundation
import UIKit

class KiflixPlayerVC: UIViewController {
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playButton: UIButton!
    let player = KiflixPlayer.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerView.player = player
        toggleButtonUI()
    }
// MARK: - KiflixPlayerView custom function
    func setPlayer(playerUrlString: String) {
        guard let previewURL = URL(string: playerUrlString) else { return }
        let playerItem = AVPlayerItem(url: previewURL)
        KiflixPlayer.shared.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func toggleButtonUI() {
        if (player.isPlaying) {
            self.playButton.isSelected = true
        } else {
            self.playButton.isSelected = false
        }
    }
    
// MARK: - KiflixPlayerView @IBAction function
    @IBAction func handlePlayButton(_ sender: Any) {
        if (player.isPlaying == false) {
            player.play()
        } else {
            player.pause()
        }
        toggleButtonUI()
    }
    
    @IBAction func handleFullscreenButton(_ sender: Any) {
        self.playerView.player = nil
        let fullscreenVC = FullScreenPlayerVC(nibName: "FullScreenPlayerVC", bundle: nil)
        fullscreenVC.modalPresentationStyle = .fullScreen
        self.present(fullscreenVC, animated: false, completion: nil)
    }
}

