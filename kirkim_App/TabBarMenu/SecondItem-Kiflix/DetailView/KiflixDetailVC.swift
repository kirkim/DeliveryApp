//
//  KiflixDetailVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/02.
//

import UIKit

class KiflixDetailVC: UIViewController {
    private var previewUrl: String?
    @IBOutlet weak var contentView: UIView!
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(previewUrl: String) {
        self.init(nibName: "KiflixDetailVC", bundle: nil)
        self.previewUrl = previewUrl
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addContentsView()
        
    }
    
    private func addContentsView() {
        let contentVC = KiflixPlayerVC(nibName: "KiflixPlayerVC", bundle: nil)
        addChild(contentVC)
        contentVC.view.frame = contentView.frame
        contentView.addSubview(contentVC.view)
        contentVC.didMove(toParent: self)
        guard let urlString = self.previewUrl else { return }
        contentVC.setPlayer(playerUrlString: urlString)
    }
}
