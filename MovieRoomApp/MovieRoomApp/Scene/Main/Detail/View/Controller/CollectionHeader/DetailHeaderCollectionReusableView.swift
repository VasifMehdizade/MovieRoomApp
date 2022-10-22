//
//  DetailHeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit
import WebKit

protocol DetailHeaderCollectionViewDelegate {
    func bookmarkButtonTapped(info : WishList)
}

class DetailHeaderCollectionReusableView: UICollectionReusableView, WKUIDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkIcon: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var descriptinLabelItself: UILabel!
    @IBOutlet weak var view: UIView!
    
    // MARK: Variables
        
    var data: Detail?
        
    var delegate : DetailHeaderCollectionViewDelegate?
    
    override func layoutSubviews() {
        genresCollectionView.register(UINib(nibName: "GenresCell", bundle: nil), forCellWithReuseIdentifier: "GenresCell")
    }
    
    @IBAction func bookmarkIconButtonTapped(_ sender: Any) {
        delegate?.bookmarkButtonTapped(info: WishList(title: data?.originalTitle ?? "", overview: data?.overview ?? "", imdbRatings: data?.imdbID ?? "", image: data?.posterPath ?? "", movieId: data?.id ?? 0))
    }
    
    func config(data: Detail?, videos: [MovieResults]) {
        self.data = data
        movieName.text = data?.originalTitle
        starImage.image = UIImage(named: "Star")
        descriptinLabelItself.text = "Description"
        descriptionLabel.text = data?.overview
        genresCollectionView.reloadData()
        let a = data?.voteAverage ?? 0
        let y = Double(round(10 * a) / 10)
        imdbLabel.text = "\(y)/10 IMDb"

        let urlString = "https://www.youtube.com/watch?v=\(videos.first?.key ?? "")"
        let request = URLRequest(url: URL(string: urlString)!)
        webView.load(request)
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

extension DetailHeaderCollectionReusableView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as! GenresCell
        cell.genresLabel.text = data?.genres?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 4 - 10, height: 28)
    }
}
