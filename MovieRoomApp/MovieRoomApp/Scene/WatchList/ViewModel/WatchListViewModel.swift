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
    
    func uploadImage(image: UIImage, name: String, complete: @escaping(()->())) {
        let ref = Storage.storage().reference()
        let imageRef = ref.child("\(name).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let data = image.jpegData(compressionQuality: 0.3) ?? Data()
        let _ = imageRef.putData(data, metadata: metadata) { _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                complete()
            }
        }
    }
}
