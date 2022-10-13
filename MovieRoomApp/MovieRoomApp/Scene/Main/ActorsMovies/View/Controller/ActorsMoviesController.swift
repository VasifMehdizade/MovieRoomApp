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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 200)
    }
}
