//
//  SimilarMoviesController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 27.10.22.
//

import UIKit

class SimilarMoviesController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = DetailViewModel()
        
    var movieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationViewModel()
        cellRegister()
    }
    
    func cellRegister() {
        collectionView.register(UINib(nibName: "WatchListViewCell", bundle: nil), forCellWithReuseIdentifier: "WatchListViewCell")
    }
    
    func configurationViewModel() {
        showLoader()
        viewModel.similarMovies(id: movieId)
        viewModel.errorCallback = { message in
            self.dismissLoader()
            self.showAlert(message: message) {}
        }
        
        viewModel.successCallback = {
            self.dismissLoader()
            self.collectionView.reloadData()
        }
    }
    

}

extension SimilarMoviesController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.similarMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchListViewCell", for: indexPath) as! WatchListViewCell
        cell.starImage.image = UIImage(named: "Star")
        cell.movieLabel.text = viewModel.similarMovie[indexPath.row].originalTitle
        cell.overview.text = viewModel.similarMovie[indexPath.row].overview
        cell.movieImage.sd_setImage(with: URL(string: viewModel.similarMovie[indexPath.row].image))

        let a = viewModel.similarMovie[indexPath.row].voteAverage
        let y = Double(round(10 * a) / 10)
        cell.imdbLabel.text = "\(y)/10 IMDb"
                
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        controller.movieId = viewModel.similarMovie[indexPath.row].id
        navigationController?.show(controller, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 200)
    }
    
}
