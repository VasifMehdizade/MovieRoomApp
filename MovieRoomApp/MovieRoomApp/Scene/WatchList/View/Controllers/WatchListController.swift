//
//  WatchListController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 29.09.22.
//

import UIKit

class WatchListController: UIViewController {
    
    var viewModel = WatchListViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureNavigation()
        
        viewModel.getMyNews {
            self.collectionView.reloadData()
        }
    }
    
    func configureNavigation() {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "WatchListViewCell", bundle: nil), forCellWithReuseIdentifier: "WatchListViewCell")
    }
    
}

extension WatchListController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchListViewCell", for: indexPath) as! WatchListViewCell
        cell.
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 120)
    }
}
