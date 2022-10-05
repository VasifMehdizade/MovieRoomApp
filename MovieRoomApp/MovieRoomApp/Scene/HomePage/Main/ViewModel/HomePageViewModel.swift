//
//  HomePageViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 25.09.22.
//

import Foundation

class HomePageViewModel {
    
    // MARK: Variables

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
        HomePageManager.shared.getGenres(genres: genre) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items?.results {
                self.genreMovies = docs
                self.successCallback?()
            }
        }
    }
}
