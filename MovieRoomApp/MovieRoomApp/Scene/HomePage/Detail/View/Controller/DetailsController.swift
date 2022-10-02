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
    
    var variable = HomePageController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        configurationViewModel()
        registerCell()
        
    }
    
    func registerCollectionView () {
        collectionView.register(UINib(nibName: "\(DetailHeaderCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)")
    }
    
    func configurationViewModel() {
        showLoader()
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
        collectionView.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
    }
    
}

extension DetailsController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        
        variable.selectionIdCallBack = { id in
            self.viewModel.movieCast(id: id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)", for: indexPath) as! DetailHeaderCollectionReusableView
            headerView.config()
            headerView.imdbLabel.text = viewModel.moviesCasts.gender

            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
}
