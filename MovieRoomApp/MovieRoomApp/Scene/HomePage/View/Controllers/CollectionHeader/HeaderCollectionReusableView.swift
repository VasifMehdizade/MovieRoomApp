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
        configurationViewModel()
    }
    
    override func layoutSubviews() {
        collectionViewNowPlaying.register(UINib(nibName: "MoviesCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2 - 20, height: 230)
    }
}
