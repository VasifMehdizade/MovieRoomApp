//
//  SearchController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 26.09.22.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configurationViewModel()

    }
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        viewModel.getSearchResults(text: sender.text ?? "")

    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "SearchViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchViewCell")
    }
    
    func configurationViewModel() {
//        showLoader()
//        viewModel.getSearchResults(text: String)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchViewCell", for: indexPath) as! SearchViewCell
        cell.configure(item: viewModel.searchResults[indexPath.item])
        return cell
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 220)
    }
    
}
