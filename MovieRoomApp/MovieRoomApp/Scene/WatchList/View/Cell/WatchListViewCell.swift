//
//  WatchListViewCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 10.10.22.
//

import UIKit

class WatchListViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
