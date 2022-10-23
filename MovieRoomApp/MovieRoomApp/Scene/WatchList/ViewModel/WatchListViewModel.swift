//
//  WatchListViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 18.10.22.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class WatchListViewModel {
    
    var items = [MyList]()

    func getMyNews(complete : @escaping(()->())) {
        let db = Firestore.firestore()
        let collection = db.collection("MyCollection").document("rFxCHAZhV4Bf9fO0wqEl")
        collection.getDocument { snapshot, error in
            if let snapshot = snapshot , snapshot.exists, let data = snapshot.data() {
                if let data = try? JSONSerialization.data(withJSONObject: data, options: []) {
                    guard let items = try? JSONDecoder().decode(ListItems.self, from: data) else {return}
                    self.items = items.items
                    complete()
                }
            } else {
                print("error")
            }
        }
    }
}
