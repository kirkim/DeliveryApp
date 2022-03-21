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
    private var observerCount: Int = 0
    private var switchObserver: Bool = false
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tapBackground()
        player.play()
        timer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerView.player = player
        toggleButtonUI()
        switchObserver = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        disappearObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        switchObserver = false
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
        self.controlView.isHidden = false
//        addObserverGage()
    }
    
    func tapBackground() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(taphandler))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
// MARK: - KiflixPlayerView @IBAction function
    @IBAction func togglePlayButton(_ sender: Any) {
//        addObserverGage()
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
    
// MARK: - KiflixPlayerView Observer function
    func addObserverGage() {
        self.observerCount += 1
        DispatchQueue.global().async {
            sleep(3)
            self.observerCount -= 1
        }
    }
    
    func disappearObserver() {
        DispatchQueue.global().async {
            while(self.switchObserver) {
                sleep(1)
                if (self.observerCount == 0) {
                    DispatchQueue.main.async {
                        self.controlView.isHidden = true
                    }
                }
            }
        }
    }
}

// MARK: - KiflixPlayerView player timer
import RxSwift
import RxCocoa
import RxGesture

extension KiflixPlayerVC {
    func timer() {
        print("here")
        self.view.rx.tapGesture()
//            .when(.recognized)
            .timeout(.seconds(15), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { _ in
                self.controlView.isHidden = false
            },
                onError: { _ in
                self.controlView.isHidden = true
            })
            .disposed(by: disposeBag)
    }
}
