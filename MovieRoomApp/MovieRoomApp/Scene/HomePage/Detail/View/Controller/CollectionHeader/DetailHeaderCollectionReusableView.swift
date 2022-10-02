//
//  DetailHeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit
import WebKit

class DetailHeaderCollectionReusableView: UICollectionReusableView {
    
    var viewModel = DetailViewModel()
    
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
        
        descriptionLabel.text = "Description"
    }
    
    override func layoutSubviews() {
        genresCollectionView.register(UINib(nibName: "GenresCell", bundle: nil), forCellWithReuseIdentifier: "GenresCell")
    }
    
    func config() {
        configurationViewModel()
    }

    private func configurationViewModel() {
        showLoader()
//        viewModel.moviesCasts()
        viewModel.errorCallback = { message in
            self.dismissLoader()
            self.showAlert(message: message) {}
        }

        viewModel.successCallback = {
            self.dismissLoader()
            self.genresCollectionView.reloadData()
        }
    }
    
}

extension DetailHeaderCollectionReusableView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.moviesCasts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as! GenresCell
        cell.configure(item: viewModel.moviesDetails?.genres[indexPath.row].name as! GenresCellProtocol)
        return cell
    }
    
}
