//
//  ActorsMoviesCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 13.10.22.
//

import UIKit
import SDWebImage

protocol ActorsMoviesCellProtocol {
    var image : String {get}
    var name : String {get}
    var movieOverview : String {get}
}

class ActorsMoviesCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    func configure(item : ActorsMoviesCellProtocol) {
        movieImage.sd_setImage(with: URL(string: item.image))
        movieTitle.text = item.name
        movieOverview.text = item.movieOverview
    }
    

}
