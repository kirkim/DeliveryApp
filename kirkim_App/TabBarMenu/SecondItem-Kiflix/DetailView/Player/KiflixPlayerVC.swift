//
//  KiflixPlayerVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/03.
//

import AVFoundation
import UIKit

class KiflixPlayerVC: UIViewController {
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playButton: UIButton!
    let player = KiflixPlayer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapBackground()
        player.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerView.player = player
        toggleButtonUI()
    }
// MARK: - KiflixPlayerVC init
    init(playerUrlString: String) {
        super.init(nibName: "KiflixPlayerVC", bundle: nil)
        guard let previewURL = URL(string: playerUrlString) else { return }
        let playerItem = AVPlayerItem(url: previewURL)
        KiflixPlayer.shared.replaceCurrentItem(with: playerItem)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        player.pause()
        player.replaceCurrentItem(with: nil)
    }
// MARK: - KiflixPlayerVC custom function
    func toggleButtonUI() {
        if (player.isPlaying) {
            self.playButton.isSelected = true
        } else {
            self.playButton.isSelected = false
        }
    }
    @objc func taphandler() {
        UIView.animate(withDuration: 0.1, animations: { self.controlView.alpha = 1 }) { (true) in self.controlView.isHidden = false }
    }
    
    func tapBackground() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(taphandler))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
// MARK: - KiflixPlayerView @IBAction function
    @IBAction func togglePlayButton(_ sender: Any) {
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

