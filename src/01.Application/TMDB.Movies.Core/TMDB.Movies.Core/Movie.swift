//
//  Movie.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation

public class Movie: Codable {
    
    public var adult: Bool?
    public var backdropPath: String?
    public var genreIds: [Int]?
    public var id: Int?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var releaseDate: String?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?
    
    public init(
        adult: Bool? = nil,
        backdropPath: String? = nil,
        genreIds: [Int]? = nil,
        id: Int? = nil,
        originalLanguage: String? = nil,
        originalTitle: String? = nil,
        overview: String? = nil,
        popularity: Double? = nil,
        posterPath: String? = nil,
        releaseDate: String? = nil,
        title: String? = nil,
        video: Bool? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
