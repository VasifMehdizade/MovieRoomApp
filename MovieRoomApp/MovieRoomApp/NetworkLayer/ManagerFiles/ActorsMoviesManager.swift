//
//  ActorsMoviesManager.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 13.10.22.
//

import Foundation

class ActorsMoviesManager {
    static let shared = ActorsMoviesManager()
    
    func getMoviesOfActors (id: Int, complete: @escaping ((ActorMovies?, String?)->())) {
        let url = "https://api.themoviedb.org/3/person/\(id)/movie_credits?api_key=d8255fdb07be4ce132643e5e155bf54b&language=en-US"
        NetworkManager.shared.request(type: ActorMovies.self, url: url, method: .get) { response in
            switch response {
            case .success(let model):
                complete(model, nil)
            case .failure(let error):
                complete(nil, error.localizedDescription)
            }
        }
    }
}
