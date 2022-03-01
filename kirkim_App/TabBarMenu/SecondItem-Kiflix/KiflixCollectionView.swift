//
//  KiflixCollectionView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit

class KiflixCollectionView: UICollectionView {
    let kiflixModel = KiflixModel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registCell()
    }
    
    private func registCell() {
        let nib = UINib(nibName: "KiflixCollectionCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "KiflixCollectionCell")
        self.dataSource = self
        self.delegate = self
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
}

//MARK: - UICollectionViewDelegateFlowLayout
extension KiflixCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let margin: CGFloat = 8
        let width: CGFloat = (self.frame.width - (spacing * 2) - (margin * 2)) / 3
        let height: CGFloat = width * (10/7)
        return CGSize(width: width, height: height)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
