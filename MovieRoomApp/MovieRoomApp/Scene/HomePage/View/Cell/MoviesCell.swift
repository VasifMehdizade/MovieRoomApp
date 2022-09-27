//
//  MoviesCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit
import SDWebImage

protocol MoviesCellProtocol {
    var moviePhoto : String { get }
}

class MoviesCell: UICollectionViewCell {
    @IBOutlet private weak var moviesImage: UIImageView!
    
    func configure(item : MoviesCellProtocol) {
        moviesImage.sd_setImage(with: URL(string: item.moviePhoto))
    }
}
