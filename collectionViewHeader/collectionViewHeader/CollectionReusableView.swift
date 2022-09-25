//
//  CollectionReusableView.swift
//  collectionViewHeader
//
//  Created by Vasif Mehdi on 24.09.22.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var collectionviewUp: UICollectionView!
    @IBOutlet weak var collectionViewDown: UICollectionView!
    override func awakeFromNib() {
        
        collectionviewUp.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        collectionViewDown.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        
 
        super.awakeFromNib()
    }
    
}

extension CollectionReusableView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionviewUp.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
//        let cell1 = collectionViewDown.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionviewUp)  {
            return 2
    }
    return 1
    
    
}
}
