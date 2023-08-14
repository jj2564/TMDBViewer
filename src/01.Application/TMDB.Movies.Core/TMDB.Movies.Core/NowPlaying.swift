//
//  NowPlaying.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation

public struct NowPlaying: Codable {
    public var dates: DateRange?
    public var page: Int?
    public var results: [Movie]?
    public var totalPages: Int?
    public var totalResults: Int?
}

public struct DateRange: Codable {
    public var maximum: String?
    public var minimum: String?
}
