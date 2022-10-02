//
//  CastCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import UIKit
import SDWebImage

protocol CastCellProtocol {
    var cellLabel : String {get}
    var cellImage : String { get}
}

class CastCell: UICollectionViewCell {

    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure (item : CastCellProtocol) {
        castImage.sd_setImage(with: URL(string: item.cellImage))
        castLabel.text = item.cellLabel
    }

}
