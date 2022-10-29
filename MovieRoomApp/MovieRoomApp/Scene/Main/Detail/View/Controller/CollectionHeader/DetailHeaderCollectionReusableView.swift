//
//  DetailHeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit
import SDWebImage

protocol DetailHeaderCollectionViewDelegate {
    func bookmarkButtonTapped(info : WishList)
}

class DetailHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkIcon: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var descriptinLabelItself: UILabel!
    @IBOutlet weak var view: UIView!
        
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var playingButton: UIButton!
    
    // MARK: Variables
        
    var data: Detail?
    
    var videos = [MovieResults]()
        
    var delegate : DetailHeaderCollectionViewDelegate?
    
    var viewModel = WatchListViewModel()
    
    var check = false
    
    var sendingMovieTrailing : ((String)->())?

    override func layoutSubviews() {
        genresCollectionView.register(UINib(nibName: "GenresCell",
                                            bundle: nil),
                                      forCellWithReuseIdentifier: "GenresCell")
    }
    
    @IBAction func playingButton(_ sender: Any) {
        sendingMovieTrailing?(videos.first?.key ?? "")
    }
    
    @IBAction func bookmarkIconButtonTapped(_ sender: UIButton) {
        delegate?.bookmarkButtonTapped(info: WishList(title: data?.originalTitle ?? "",
                                                      overview: data?.overview ?? "",
                                                      imdbRatings: data?.voteAverage ?? 0.0,
                                                      image: "https://image.tmdb.org/t/p/original\(data?.posterPath ?? "")",
                                                      movieId: data?.id ?? 0))

         if check == true {
             bookmarkIcon.setImage(UIImage(named: "bookmark"), for: .normal)
             check = false
         } else {
             bookmarkIcon.setImage(UIImage(named: "bookmarkRed"), for: .normal)
             check = true
         }
        
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
        posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(data?.posterPath ?? "")"))
        self.videos = videos
        
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
