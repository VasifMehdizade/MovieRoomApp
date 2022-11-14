//
//  DetailsController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit
import FirebaseFirestore

class DetailsController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Variables
    
    var viewModel = DetailViewModel()
    
    var selectionIdCallBack: ((Int)->())?
    
    var movieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfig()
        configurationViewModel()
        collectionView.reloadData()
        
        navigationController?.isNavigationBarHidden = false
    }
    
    func collectionViewConfig () {
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionViewCell")
        collectionView.register(UINib(nibName: "\(DetailHeaderCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)")
    }
    
    func configurationViewModel() {
        showLoader()
        viewModel.movieDetail(id: movieId)
        viewModel.movieCast(id: movieId)
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

extension DetailsController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        if indexPath.row == 0 {
            cell.configureCell(data: viewModel.moviesCasts, title: "Cast")
            cell.selectionIdCallBack = { id in
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "ActorsMoviesController") as! ActorsMoviesController
                controller.actorId = id
                self.navigationController?.show(controller, sender: nil)
            }
        } else {
            cell.configureCell(data: viewModel.similarMovie, title: "Similar Movies")
            cell.selectionIdCallBack = { item in
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "SimilarMoviesController") as! SimilarMoviesController
                controller.movieId = item
                self.navigationController?.show(controller, sender: nil)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(DetailHeaderCollectionReusableView.self)", for: indexPath) as! DetailHeaderCollectionReusableView
            headerView.config(data: viewModel.moviesDetails, videos: viewModel.videoItems)
            headerView.delegate = self
            
            headerView.viewModel.getMyList {
                for num in headerView.viewModel.items {
                    if num.movieId == self.movieId {
                        headerView.bookmarkIcon.setImage(UIImage(named: "bookmarkRed"), for: .normal)
                    }
                }
            }
            
            headerView.sendingMovieTrailing = { url in
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "TrailerController") as! TrailerController
                controller.video = url
                self.navigationController?.show(controller, sender: nil)
            }
                
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 600)
    }
    
    func createFavoriteList(info : SaveList) {
        let data : [String : Any] = ["title" : info.title,
                                     "overview" : info.overview,
                                     "imdbRatings" : info.imdbRatings,
                                     "movieId" : info.movieId,
                                     "image" : info.image]
        let collection = Firestore.firestore().collection("MyCollection").document("rFxCHAZhV4Bf9fO0wqEl")
        collection.updateData(["items" : FieldValue.arrayUnion([data])]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.collectionView.reloadData()
            }
        }
    }
}

extension DetailsController : DetailHeaderCollectionViewDelegate{
    func bookmarkButtonTapped(info : SaveList) {
        createFavoriteList(info: info)
    }
}
