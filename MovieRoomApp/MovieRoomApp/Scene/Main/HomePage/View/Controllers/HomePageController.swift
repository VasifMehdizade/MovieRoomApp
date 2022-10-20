//  HomePageController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class HomePageController: UIViewController, UITabBarControllerDelegate {
    
    // MARK: Variables
    
    var viewModel = HomePageViewModel()
        
    // MARK: IBOutlets

    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        registerCollectionView()
        configurationViewModel()
        
        navigationController?.isNavigationBarHidden = true
//        navigationLabel.textColor = UIColor(red: 236, green: 236, blue: 236, alpha: CGFloat(100.0))
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
            headerView.selectionIdCallBack = { movieId in
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
                controller.movieId = movieId
                self.navigationController?.show(controller, sender: nil)
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
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        controller.movieId = viewModel.genreMovies[indexPath.row].id
        navigationController?.show(controller, sender: nil)
    }
    
}
