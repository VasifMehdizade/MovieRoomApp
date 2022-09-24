//
//  HeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerNowPlayingCells: UICollectionView!
    
    @IBOutlet weak var headerCategoriesCells: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
