//
//  DetailHeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit
import WebKit

class DetailHeaderCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkIcon: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var descriptinLabelItself: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        genresCollectionView.register(UINib(nibName: "GenresCell", bundle: nil), forCellWithReuseIdentifier: "GenresCell")
    }
    
//    func config() {
//        configurationViewModel()
//    }
//
//    private func configurationViewModel() {
//        showLoader()
//        viewModel.getMovies()
//        viewModel.errorCallback = { message in
//            self.dismissLoader()
//            self.showAlert(message: message) {}
//        }
//
//        viewModel.successCallback = {
//            self.dismissLoader()
//            self.collectionViewNowPlaying.reloadData()
//        }
//    }
    
    
}

//extension DetailHeaderCollectionReusableView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
