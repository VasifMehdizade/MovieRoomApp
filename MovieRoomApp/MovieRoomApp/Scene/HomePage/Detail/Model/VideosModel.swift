//
//  VideosModel.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 08.10.22.
//

import Foundation

// MARK: - Videos
struct Videos: Codable {
    let id: Int?
    let results: [MovieResults]?
}

// MARK: - Result
struct MovieResults: Codable {
    let iso639_1, iso3166_1, name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

