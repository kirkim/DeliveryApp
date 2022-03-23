//
//  KiflixCollectionView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit

class KiflixCollectionView: UICollectionView {
    let kiflixModel = KiflixViewModel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registCell()
//        setCollectionViewUI()
    }
    
    private func registCell() {
        self.dataSource = self
        let cellNib = UINib(nibName: "KiflixCollectionCell", bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: "KiflixCollectionCell")
        let detailViewNib = UINib(nibName: "KiflixDetailVC", bundle: nil)
        self.register(detailViewNib, forCellWithReuseIdentifier: "KiflixDetailVC")
    }
    
    func update(text: String) {
        kiflixModel.update(text: text, completion: {
            DispatchQueue.main.async {
                self.reloadData()
            }
        })
    }
}

//MARK: - UICollectionViewDataSource
extension KiflixCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.kiflixModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KiflixCollectionCell", for: indexPath) as? KiflixCollectionCell else { return UICollectionViewCell() }
        self.kiflixModel.getThumbnail(row: indexPath.row, completion: { image in
            DispatchQueue.main.async {
                cell.update(image: image)
            }
        })
        
        return cell
    }
    
    func setCollectionViewUI(itemSpacing: CGFloat = 8, margin: CGFloat = 2) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        self.collectionViewLayout = layout
        let width: CGFloat = (self.frame.width - (itemSpacing * 2) - (margin * 2)) / 3
        let height: CGFloat = width * (10/7)
//        layout.sectionInset = UIEdgeInsets(top: 80, left: margin, bottom: margin, right: margin)
        self.contentInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
    }
}
