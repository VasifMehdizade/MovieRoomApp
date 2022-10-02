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
    
    var categorySelectionCallBack: ((String)->())?
    var selectionIdCallBack: ((Int)->())?
    
    var categories = [GenresModel(title: "Top rated", key: "top_rated"),
                      GenresModel(title: "Upcoming", key: "upcoming"),
                      GenresModel(title: "Popular", key: "popular")]
    
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
            categoriesCell.categoriesLabel.text = categories[indexPath.row].title
            return categoriesCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == collectionViewNowPlaying {
//            // 210 - 144
//            // width - x
//            let height = collectionView.frame.height * 210 / 144 - 10
//            let width = collectionView.frame.height * 144 / 210 - 10
//            return CGSize(width: width, height: height)
//        }
        return CGSize(width: collectionView.frame.width/2 - 20, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        
        if collectionView == collectionViewCategories {
            categorySelectionCallBack?(categories[indexPath.item].key)
        } else {
            selectionIdCallBack?(viewModel.moviesInfos[indexPath.row].id)
        }
        
    }
}
