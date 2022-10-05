//
//  DetailsController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit

class DetailsController: UIViewController {
    
    // MARK: Variables
    
    var viewModel = DetailViewModel()
    
    var variable = HomePageController()
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)", for: indexPath) as! DetailHeaderCollectionReusableView
            headerView.config()
            headerView.selectionIdCallBack = { id in
                self.viewModel.movieDetail(id: id)
            }
            headerView.descriptinLabelItself.text = "Description"
            headerView.descriptionLabel.text = viewModel.moviesDetails?.overview
            headerView.movieName.text = viewModel.moviesDetails?.originalTitle
            headerView.bookmarkIcon.setImage(UIImage(named: "Save"), for: .normal)
            headerView.starImage.image = UIImage(named: "Star")
//            headerView.imdbLabel.text = String(viewModel.moviesDetails?.voteAverage)
            


            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 600)
    }
    
}
