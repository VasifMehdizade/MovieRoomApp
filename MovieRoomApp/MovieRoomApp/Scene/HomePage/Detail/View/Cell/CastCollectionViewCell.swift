//
//  CastCollectionViewCell.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    // MARK: Variables
        
    private var movieCast = [CastElement]()
    private var similarMovie = [Conclusion]()
    
    var items = [TitleImageProtocol]()

    private var selectionIdCallBack: ((Int)->())?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    func registerCell() {
        castCollectionView.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
    }
    
    func configureCell (data: [TitleImageProtocol], title : String) {
        self.cellTitle.text = title
        self.items = data
        castCollectionView.reloadData()
    }
}

extension CastCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.configureCast(item: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 4 - 10, height: 140)
    }
}
