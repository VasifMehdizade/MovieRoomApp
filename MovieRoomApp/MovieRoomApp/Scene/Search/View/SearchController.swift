//
//  SearchController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 26.09.22.
//

import UIKit

class SearchController: UIViewController {
    
    // MARK: Variables
    
    var viewModel = SearchViewModel()

    // MARK: IBOutlets

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configurationViewModel()
        configureNavigation()
        navigationController?.isNavigationBarHidden = false
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "ActorsMoviesCell", bundle: nil), forCellWithReuseIdentifier: "ActorsMoviesCell")
    }
    
    func configureNavigation() {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func configurationViewModel() {
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

extension SearchController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorsMoviesCell", for: indexPath) as! ActorsMoviesCell
        cell.configure(item: viewModel.searchResults[indexPath.row])
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        controller.movieId = viewModel.searchResults[indexPath.row].filmId
        navigationController?.show(controller, sender: nil)
    }
}

extension SearchController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.getSearchResults(text: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}
