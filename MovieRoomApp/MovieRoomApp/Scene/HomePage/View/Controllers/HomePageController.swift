//
//  HomePageController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class HomePageController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        registerCollectionView()
        configurationViewModel()
        
        self.navigationController?.isNavigationBarHidden = true

    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "MoviesCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
    }
    
    func registerCollectionView () {
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
    }
    
    func configurationViewModel() {
        showLoader()
        viewModel.getMoviesInfos()
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

extension HomePageController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        cell.configure(item: viewModel.moviesInfos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.moviesInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {

        case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath)

                return headerView
        default:
            assert(false, "Unexpected element kind")
        }
}
}
