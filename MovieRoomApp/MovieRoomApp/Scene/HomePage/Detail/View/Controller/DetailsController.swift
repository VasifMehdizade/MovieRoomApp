//
//  DetailsController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        configurationViewModel()

    }
    
    func registerCollectionView () {
        collectionView.register(UINib(nibName: "\(DetailHeaderCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)")

}
    
    func configurationViewModel() {
        showLoader()
//        viewModel.moviesDetails()
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
