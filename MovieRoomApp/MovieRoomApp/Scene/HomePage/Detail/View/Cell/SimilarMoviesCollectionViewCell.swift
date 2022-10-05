//
//  SimilarMoviesCollectionViewCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
    
    var viewModel = DetailViewModel()
    
    // MARK: IBOutlets
    
    @IBOutlet weak var similarMoviewCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    func registerCell() {
        similarMoviewCollectionView.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
    }
    
}

extension SimilarMoviesCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.similarMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.configure(item: viewModel.similarMovie[indexPath.row])
        return cell
    }
}
