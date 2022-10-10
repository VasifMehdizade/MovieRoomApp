//
//  DetailsController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit

class DetailsController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    
    var viewModel = DetailViewModel()
    
    var selectionIdCallBack: ((Int)->())?
    
    var movieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfig()
        configurationViewModel()
        collectionView.reloadData()
    }
    
    func collectionViewConfig () {
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionViewCell")
        collectionView.register(UINib(nibName: "\(DetailHeaderCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)")
    }
    
    func configurationViewModel() {
        showLoader()
        viewModel.movieDetail(id: movieId)
        viewModel.movieCast(id: movieId)
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

extension DetailsController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        cell.castCollectionView.cellForItem(at: [indexPath.row])
        selectionIdCallBack?(movieId)
        selectionIdCallBack = { movieId in
//            cell.movieId = movieId
//            cell.movieId = self.viewModel.moviesDetails?.id ?? 0
        }
        
        cell.cellTitle.text = "Cast"
//        cell.movieId = viewModel.moviesDetails?.id ?? 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)", for: indexPath) as! DetailHeaderCollectionReusableView
            headerView.config(data: viewModel.moviesDetails, videos: viewModel.videoItems)
          
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 600)
    }
}
