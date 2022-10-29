//
//  HomePageViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 25.09.22.
//

import Foundation

class HomePageViewModel {
    
    // MARK: Variables
    
    var movie : Movies?
    
    var genre = "top_rated"

    var moviesInfos = [Info]()
    var genreMovies = [Info]()

    var successCallback : (()->())?
    var errorCallback : ((String)->())?
    
    func getMovies () {
        HomePageManager.shared.getMovies { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items?.results {
                self.moviesInfos = docs
                self.successCallback?()
            }
        }
    }
    
    func getGenres(genre : String) {
        HomePageManager.shared.getGenres(genres: genre, page: (movie?.page ?? 0) + 1) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items?.results {
                self.movie = items
                self.genreMovies.append(contentsOf: docs)
                self.successCallback?()
            }
        }
    }
    
    func pagination (index : Int) {
        if let item = movie {
            if (item.page ?? 0 <= item.totalPages ?? 0 ) && index == (genreMovies.count - 1) {
                getGenres(genre: genre)
            }
        }
    }
}
