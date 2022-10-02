//
//  GenresCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import UIKit

protocol GenresCellProtocol {
    var genreLabel : String {get}
}

class GenresCell: UICollectionViewCell {

    @IBOutlet weak var genresLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure ( item: GenresCellProtocol) {
        genresLabel.text = item.genreLabel
    }

}
