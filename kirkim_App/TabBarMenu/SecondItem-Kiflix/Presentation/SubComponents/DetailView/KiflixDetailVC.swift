//
//  KiflixDetailVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/02.
//

import UIKit

class KiflixDetailVC: UIViewController {
    @IBOutlet weak var contentView: UIView! {
        didSet {
            guard let contentVC = self.contentViewController else { return }
            addChild(contentVC)
            contentView.addSubview(contentVC.view)
            contentVC.didMove(toParent: self)
        }
    }
    
    @IBOutlet weak var scrollContentView: UIStackView!

    private var contentViewController: KiflixPlayerVC?
    private var movieData: Movie?
//    private var descriptionView: DescriptionView?
    
//MARK: - KiflixDetailVC init
    init(movieData: Movie) {
        super.init(nibName: "KiflixDetailVC", bundle: nil)
        self.movieData = movieData
        contentViewController = KiflixPlayerVC(playerUrlString: movieData.previewURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - KiflixDetailVC lifeCycle function
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUI()
    }
    
//MARK: - KiflixDetailVC custom function
    private func setUI() {
        guard let contentVC = self.contentViewController else { return }
        contentVC.view.frame = contentView.frame
        addDescriptionView()
    }
    
    private func addDescriptionView() {
        let descriptionView = DescriptionView(frame: CGRect.zero)
        if let data = self.movieData {
            let descriptionData = MovieDescription(title: data.title, date: data.releaseDate, director: data.director, longDescription: data.longDescription)
            descriptionView.setData(descriptionData: descriptionData)
        }
        self.scrollContentView.addArrangedSubview(descriptionView)
    }
}
