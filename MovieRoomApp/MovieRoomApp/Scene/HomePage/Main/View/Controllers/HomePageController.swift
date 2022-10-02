//
//  HomePageController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class HomePageController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel = HomePageViewModel()
    
    var selectionIdCallBack: ((Int)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        registerCollectionView()
        configurationViewModel()
        
        self.navigationController?.isNavigationBarHidden = true
        navigationLabel.textColor = UIColor(red: 236, green: 236, blue: 236, alpha: CGFloat(1.0))
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "MoviesCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCell")
    }
    
    func registerCollectionView () {
        collectionView.register(UINib(nibName: "\(HeaderCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderCollectionReusableView.self)")
    }
    
    func configurationViewModel() {
        showLoader()
        viewModel.getGenres(genre: "top_rated")
        viewModel.getMovies()
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
        cell.configure(item: viewModel.genreMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.genreMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/3 - 10, height: 146)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderCollectionReusableView.self)", for: indexPath) as! HeaderCollectionReusableView
            headerView.config()
            headerView.categorySelectionCallBack = { genre in
                self.viewModel.getGenres(genre: genre)
            }
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 387)
    }
    
    func collectionView(_ collectionView1: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView1 == collectionView {
            selectionIdCallBack?(viewModel.moviesInfos[indexPath.row].id)
        }
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        navigationController?.show(controller, sender: nil)
    }
    
}
