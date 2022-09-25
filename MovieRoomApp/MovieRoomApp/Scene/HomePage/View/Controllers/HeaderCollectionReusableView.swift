//
//  HeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var collectionViewNowPlaying: UICollectionView!
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
