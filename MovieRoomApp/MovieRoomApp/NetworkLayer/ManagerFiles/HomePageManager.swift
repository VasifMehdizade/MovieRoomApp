//
//  HomePageManager.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import Foundation

class HomePageManager {
    static let shared = HomePageManager()
    
    func getMovies (complete: @escaping ((Movies?, String?)->())) {
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=d8255fdb07be4ce132643e5e155bf54b"
        NetworkManager.shared.request(type: Movies.self,
                                      url: url,
                                      method: .get) { response in
            switch response {
            case .success(let model) :
                complete(model, nil)
            case .failure(let error) :
                complete(nil, error.localizedDescription)
            }
        }
    }
}
