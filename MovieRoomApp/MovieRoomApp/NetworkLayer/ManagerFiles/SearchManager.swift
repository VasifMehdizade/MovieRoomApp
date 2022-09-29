//
//  SearchManager.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 26.09.22.
//

import Foundation

class SearchManager {
    static let shared = SearchManager()
    
    func searchResults (text: String, complete: @escaping ((Search?, String?)->())) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=d8255fdb07be4ce132643e5e155bf54b&language=en-US&page=1&include_adult=false&query=\(text)"
        NetworkManager.shared.request(type: Search.self, url: url, method: .get) { response in
            switch response {
            case .success(let model):
                complete(model, nil)
            case .failure(let error):
                complete(nil, error.localizedDescription)
            }
        }
    }
}
