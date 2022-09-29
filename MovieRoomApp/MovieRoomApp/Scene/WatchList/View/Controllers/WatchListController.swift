//
//  WatchListController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 29.09.22.
//

import UIKit

class WatchListController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    func configureNavigation() {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
}
