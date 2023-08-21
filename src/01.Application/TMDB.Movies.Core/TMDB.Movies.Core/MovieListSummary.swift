//
//  MovieListSummary.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation

public struct MovieListSummary: Codable {
    public var dates: DateRange?
    public var page: Int?
    public var results: [Movie]?
    public var totalPages: Int?
    public var totalResults: Int?
    
    public init(
        dates: DateRange? = nil,
        page: Int? = nil,
        results: [Movie]? = nil,
        totalPages: Int? = nil,
        totalResults: Int? = nil
    ) {
        self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

public struct DateRange: Codable {
    public var maximum: String?
    public var minimum: String?
}
