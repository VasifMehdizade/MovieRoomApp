//
//  DetailManager.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import Foundation

class DetailManager {
    static let shared = DetailManager()
    
    func movieDetail (id: Int, complete: @escaping ((Detail?, String?)->())) {
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=d8255fdb07be4ce132643e5e155bf54b&language=en-US"
        NetworkManager.shared.request(type: Detail.self, url: url, method: .get) { response in
            switch response {
            case .success(let model):
                complete(model, nil)
            case .failure(let error):
                complete(nil, error.localizedDescription)
            }
        }
    }
    
    func movieCast (id: Int, complete: @escaping ((Cast?, String?)->())) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=d8255fdb07be4ce132643e5e155bf54b&language=en-US"
        NetworkManager.shared.request(type: Cast.self, url: url, method: .get) { response in
            switch response {
            case .success(let model):
                complete(model, nil)
            case .failure(let error):
                complete(nil, error.localizedDescription)
            }
        }
    }
    
    func similarMovies (id: Int, complete: @escaping ((Similar?, String?)->())) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=d8255fdb07be4ce132643e5e155bf54b&language=en-US"
        NetworkManager.shared.request(type: Similar.self, url: url, method: .get) { response in
            switch response {
            case .success(let model):
                complete(model, nil)
            case .failure(let error):
                complete(nil, error.localizedDescription)
            }
        }
    }
    
    func getVideos (id: Int, complete: @escaping ((Videos?, String?)->())) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=d8255fdb07be4ce132643e5e155bf54b&language=en-US"
        NetworkManager.shared.request(type: Videos.self, url: url, method: .get) { response in
            switch response {
            case .success(let model):
                complete(model, nil)
            case .failure(let error):
                complete(nil, error.localizedDescription)
            }
        }
    }
    
}
