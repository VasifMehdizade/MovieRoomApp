//
//  CastCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import UIKit
import SDWebImage

protocol TitleImageProtocol {
    var titleText: String { get }
    var image: String { get }
    var dataId: Int { get }
}

class CastCell: UICollectionViewCell {
        
    // MARK: IBOutlets

    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    
    func configureCast (item : TitleImageProtocol) {
        castImage.sd_setImage(with: URL(string: item.image))
        castLabel.text = item.titleText
    }
}

