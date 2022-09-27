//
//  HeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var collectionViewNowPlaying: UICollectionView!
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    
    var viewModel = HomePageViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        collectionViewNowPlaying.register(UINib(nibName: "MoviesCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
    }
}

extension HeaderCollectionReusableView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        if (collectionView == collectionViewNowPlaying)  {
            cell.configure(item: viewModel.moviesInfos[indexPath.item])
    }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if (collectionView == collectionViewNowPlaying)  {
                return viewModel.moviesInfos.count
        }
        return 1
    }
}
