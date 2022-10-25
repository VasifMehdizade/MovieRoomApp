//
//  WatchListController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 29.09.22.
//

import UIKit
import SDWebImage

class WatchListController: UIViewController {
    
    var viewModel = WatchListViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getMyList {
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
        cell.overview.text = viewModel.items[indexPath.row].overview
        cell.movieLabel.text = viewModel.items[indexPath.row].title
        
        let a = viewModel.items[indexPath.row].imdbRatings
        let y = Double(round(10 * a) / 10)
        cell.imdbLabel.text = "\(y)/10 IMDb"
        
        cell.starImage.image = UIImage(named: "Star")
        cell.movieImage.sd_setImage(with: URL(string: viewModel.items[indexPath.row].image))
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 220)
    }
}
