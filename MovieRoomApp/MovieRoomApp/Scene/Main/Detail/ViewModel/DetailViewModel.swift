//
//  DetailViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import Foundation

class DetailViewModel {
    
    // MARK: Variables
    
    var moviesDetails: Detail?
    var moviesCasts = [CastElement]()
    var similarMovie = [Conclusion]()
    var videoItems = [MovieResults]()
    var actorsMovie = [Casting]()
    

    var successCallback : (()->())?
    var errorCallback : ((String)->())?
    
    func movieDetail (id: Int) {
        DetailManager.shared.movieDetail(id: id) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items {
                self.moviesDetails = docs
                self.getVideos(id: id)
                self.successCallback?()
            }
        }
    }
    
    
    
    func movieCast(id : Int) {
        DetailManager.shared.movieCast(id: id) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items?.cast {
                self.moviesCasts = docs
                self.successCallback?()
                self.getVideos(id: id)
            }
        }
    }
    
    func similarMovies(id : Int) {
        DetailManager.shared.similarMovies(id: id) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items?.results {
                self.similarMovie = docs
                self.successCallback?()
            }
        }
    }
    
    func getVideos(id : Int) {
        DetailManager.shared.getVideos(id: id) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let videos = items?.results {
                self.videoItems = videos
                self.successCallback?()
            }
        }
    }
    
    func getMoviesOfActors(id : Int) {
        ActorsMoviesManager.shared.getMoviesOfActors(id: id) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let data = items?.cast {
                self.actorsMovie = data
                self.successCallback?()
            }
        }
    }
}
