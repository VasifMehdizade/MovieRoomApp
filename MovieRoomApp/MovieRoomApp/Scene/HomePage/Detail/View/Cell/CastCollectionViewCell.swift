//
//  CastCollectionViewCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
    
    var viewModel = DetailViewModel()
    
    var movieId = 0
    
    var selectionIdCallBack: ((Int)->())?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        castCollectionView.reloadData()
        configurationViewModel()
    }
    
    func registerCell() {
        castCollectionView.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
    }
    
    func configurationViewModel() {
        showLoader()
        selectionIdCallBack = { movieId in
            self.viewModel.movieCast(id: movieId)
        }
        viewModel.errorCallback = { message in
            self.dismissLoader()
            self.showAlert(message: message) {}
        }
        
        viewModel.successCallback = {
            self.dismissLoader()
            self.castCollectionView.reloadData()
        }
    }
}

extension CastCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.moviesCasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.configureCast(item: viewModel.moviesCasts[indexPath.row])
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
    }
