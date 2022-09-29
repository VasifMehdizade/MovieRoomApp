//
//  HeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet private weak var collectionViewNowPlaying: UICollectionView!
    @IBOutlet private weak var collectionViewCategories: UICollectionView!
    
    var viewModel = HomePageViewModel()
    
    var categories = ["Now Playing", "Top rated", "Upcoming", "Popular", "Latest"]
    
    override func layoutSubviews() {
        collectionViewNowPlaying.register(UINib(nibName: "MoviesCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
        collectionViewCategories.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
    }
    
    func config() {
        configurationViewModel()
    }
    
    private func configurationViewModel() {
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewNowPlaying)  {
            return viewModel.moviesInfos.count
        }
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewNowPlaying)  {
            let nowPlayingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
            nowPlayingCell.configure(item: viewModel.moviesInfos[indexPath.item])
            return nowPlayingCell
        } else {
            let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            categoriesCell.categoriesLabel.text = categories[indexPath.row]
            return categoriesCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewNowPlaying {
            // 210 - 144
            // width - x
            let height = collectionView.frame.height * 210 / 144 - 10
            let width = collectionView.frame.height * 144 / 210 - 10
            return CGSize(width: width, height: height)
        }
        return CGSize(width: collectionView.frame.width/2 - 20, height: 230)
    }
}
