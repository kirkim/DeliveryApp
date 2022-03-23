//
//  DescriptionView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/04.
//

import UIKit

class DescriptionView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    var model = DescriptionViewModel()
    
//MARK: DescriptionView init & connect .xib
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib(nib: "DescriptionView") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

//MARK: - DescriptionView custom function
    func setData(descriptionData: MovieDescription) {
        model.setData(data: descriptionData, completion: {
            self.setValue()
        })
    }

    func setValue() {
        self.title.text = model.getTitle()
        self.date.text = model.getDate()
        self.director.text = model.getDirector()
        self.longDescription.text = model.getLongDescription()
    }
}

struct MovieDescription {
    let title: String
    let date: String
    let director: String
    let longDescription: String?
}

class DescriptionViewModel {
    var data: MovieDescription?
    
    func setData(data: MovieDescription, completion: @escaping () -> Void) {
        self.data = data
        completion()
    }
    
    func getTitle() -> String {
        guard let hasData = self.data else { return "" }
        return hasData.title
    }
    
    func getDate() -> String {
        guard let hasData = self.data else { return "" }
        return hasData.date
    }
    
    func getDirector() -> String {
        guard let hasData = self.data else { return "" }
        return hasData.director
    }
    
    func getLongDescription() -> String {
        guard let hasData = data,
              let description = hasData.longDescription else { return "" }
        return description
    }
}

