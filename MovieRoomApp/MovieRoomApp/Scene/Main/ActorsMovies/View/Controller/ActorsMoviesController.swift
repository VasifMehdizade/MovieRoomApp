//
//  ActorsMoviesController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 13.10.22.
//

import UIKit

class ActorsMoviesController: UIViewController {
    
    // MARK: Variables
    
    var viewModel = DetailViewModel()
    
    var actorId = 0
        
    // MARK: IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configurationViewModel()
    }
    
    func configurationViewModel() {
        showLoader()
        viewModel.getMoviesOfActors(id: actorId)
        viewModel.errorCallback = { message in
            self.dismissLoader()
            self.showAlert(message: message) {}
        }
        
        viewModel.successCallback = {
            self.dismissLoader()
            self.collectionView.reloadData()
        }
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "ActorsMoviesCell", bundle: nil), forCellWithReuseIdentifier: "ActorsMoviesCell")
    }
    
}

extension ActorsMoviesController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.actorsMovie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsMoviesCell", for: indexPath) as! ActorsMoviesCell
        cell.configure(item: viewModel.actorsMovie[indexPath.row])
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        controller.movieId = viewModel.actorsMovie[indexPath.row].filmId
        navigationController?.show(controller, sender: nil)
    }
}
