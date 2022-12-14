// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? newJSONDecoder().decode(Movies.self, from: jsonData)

import Foundation

// MARK: - Movies
struct Search: Codable {
    let page: Int
    let results: [SearchResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchResult: Codable, ActorsMoviesCellProtocol {
    var image: String {
        "https://image.tmdb.org/t/p/original\(posterPath)"
    }
    
    var name: String{
        originalTitle
    }
    
    var movieOverview: String{
        overview
    }
        
    var filmId: Int {
        id
    }
    
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: Language
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

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

enum Language: String, Codable {
    case de = "de"
    case en = "en"
    case ja = "ja"
}
