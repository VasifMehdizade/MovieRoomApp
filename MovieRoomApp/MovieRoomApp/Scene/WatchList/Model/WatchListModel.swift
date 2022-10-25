//
//  WatchListModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 19.10.22.
//

import Foundation

struct ListItems : Codable {
    let items : [MyList]
}

struct MyList : Codable{
    let title : String
    let overview : String
    let movieId : Int
    let imdbRatings : Double
    let image : String
}
