//
//  NetworkHelper.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 24.09.22.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
//    let baseURL =
}
