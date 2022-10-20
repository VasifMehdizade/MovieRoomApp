//
//  WatchListModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 19.10.22.
//

import Foundation

struct NewsItems : Codable {
    let items : [MyNews]
}

struct MyNews : Codable{
    let title : String
}
