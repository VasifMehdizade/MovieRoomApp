//
//  UICollectionReusableView + Ext.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 29.09.22.
//

import Foundation
import ProgressHUD


extension UICollectionReusableView {
    func showLoader() {
        ProgressHUD.show()
    }
    
    func dismissLoader() {
        ProgressHUD.dismiss()
    }
}
