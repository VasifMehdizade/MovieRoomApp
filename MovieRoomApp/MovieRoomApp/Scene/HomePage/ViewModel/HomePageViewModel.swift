//
//  HomePageViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 25.09.22.
//

import Foundation

class HomePageViewModel {
    var moviesInfos = [Info]()

    var successCallback : (()->())?
    var errorCallback : ((String)->())?
    
    
    func getMoviesInfos () {
        HomePageManager.shared.getMovies { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items?.results {
                self.moviesInfos = docs
                self.successCallback?()
            }
        }
    }
}
