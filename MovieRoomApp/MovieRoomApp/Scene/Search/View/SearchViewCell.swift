//
//  SearchViewCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 26.09.22.
//

import UIKit
import SDWebImage

protocol SearchViewCellProtocol {
    var searchImage : String { get }
    var searchLabel : String { get }
}

class SearchViewCell: UICollectionViewCell {
    @IBOutlet weak var searchCellImage: UIImageView!
    @IBOutlet weak var searchCellView: UIView!
    @IBOutlet weak var searchCellLabel: UILabel!
    
    func configure( item : SearchViewCellProtocol) {
        searchCellImage.sd_setImage(with: URL(string: item.searchImage))
        searchCellLabel.text = item.searchLabel
    }

}

