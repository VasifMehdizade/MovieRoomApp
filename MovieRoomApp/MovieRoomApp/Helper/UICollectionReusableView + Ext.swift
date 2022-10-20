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

extension UICollectionReusableView{
    func showAlert(title: String = "", message : String = "" , okHandler : @escaping (()->())) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            okHandler()
        })
        alertController.addAction(cancel)
        alertController.addAction(ok)
//        present(alertController, animated: true, completion: nil)
    }
}
