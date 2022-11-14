//
//  WatchListViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 18.10.22.
//

import Foundation
import FirebaseFirestore

class WatchListViewModel {
    
    var items = [MyList]()
    
    var jsonModel = [Model]()
    
    var array = [Any]()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        jsonSetup()
//    }

    func getMyList(complete : @escaping(()->())) {
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
    
    func jsonSetup() {
        if let jsonFile = Bundle.main.url(forResource: "File", withExtension: "json"), let data = try? Data(contentsOf: jsonFile) {
            do {
                jsonModel = try JSONDecoder().decode([Model].self, from: data)
            } catch let error {
                print(String(describing: error))
            }
        }
    }
}
