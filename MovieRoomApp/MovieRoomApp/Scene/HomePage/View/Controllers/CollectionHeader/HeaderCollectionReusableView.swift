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
    
    var categories = ["Now Playing", "Top rated", "Upcoming", "Popular", "Latest"]

    override func awakeFromNib() {
        super.awakeFromNib()
        configurationViewModel()
    }
    
    override func layoutSubviews() {
        collectionViewNowPlaying.register(UINib(nibName: "MoviesCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
        collectionViewCategories.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
    }
    
    func configurationViewModel() {
        showLoader()
        viewModel.getMovies()
        viewModel.errorCallback = { message in
            self.dismissLoader()
            self.showAlert(message: message) {}
        }
        
        viewModel.successCallback = {
            self.dismissLoader()
            self.collectionViewNowPlaying.reloadData()
        }
    }
}

extension HeaderCollectionReusableView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nowPlayingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        if (collectionView == collectionViewNowPlaying)  {
            nowPlayingCell.configure(item: viewModel.moviesInfos[indexPath.item])
    }
        else {
            let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            categoriesCell.categoriesLabel.text = categories[indexPath.row]
            return categoriesCell
    }
        return nowPlayingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if (collectionView == collectionViewNowPlaying)  {
                return viewModel.moviesInfos.count
        }
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2 - 20, height: 230)
    }
}
