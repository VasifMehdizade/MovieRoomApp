//
//  SearchViewModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 26.09.22.
//

import Foundation

class SearchViewModel {
    var searchResults = [SearchResult]()

    var successCallback : (()->())?
    var errorCallback : ((String)->())?
    
    
    func getSearchResults (text : String) {
        SearchManager.shared.searchResults(text: text) { items, errorMessage in
            if let errorMessage = errorMessage {
                self.errorCallback?(errorMessage)
            } else if let docs = items?.results {
                self.searchResults = docs
                self.successCallback?()
            }
        }
    }
}
