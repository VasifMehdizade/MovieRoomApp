//
//  DetailViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import Foundation

class DetailViewModel {
    var moviesDetails : Detail?
    var moviesCasts = [CastElement]()

    var successCallback : (()->())?
    var errorCallback : ((String)->())?
    
    
    func movieDetail (id: Int) {
        DetailManager.shared.movieDetail(id: id) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items {
                self.moviesDetails = docs
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
            }
        }
    }
}
