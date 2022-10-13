//
//  SimilarMoviesMovies.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 02.10.22.
//

import Foundation

// MARK: - Similar
struct Similar: Codable {
    let page: Int
    let results: [Conclusion]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Conclusion: Codable, TitleImageProtocol {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var dataId: Int {
        id
    }
    
    var titleText: String {
        originalTitle
    }
    
    var image: String {
        "https://image.tmdb.org/t/p/original\(posterPath)"
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
