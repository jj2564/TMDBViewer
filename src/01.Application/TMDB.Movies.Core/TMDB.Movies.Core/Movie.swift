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
    public var releaseDate: Date?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?
    
    // detail
    public var budget: Int?
    public var genres: [Genre]?
    public var homepage: String?
    public var imdbId: String?
    public var productionCompanies: [ProductionCompany]?
    public var productionCountries: [ProductionCountry]?
    public var revenue: Int?
    public var runtime: Int?
    public var spokenLanguages: [SpokenLanguage]?
    public var status: String?
    public var tagline: String?
    
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
        releaseDate: Date? = nil,
        title: String? = nil,
        video: Bool? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        
        // detail
        budget: Int? = nil,
        genres: [Genre]? = nil,
        homepage: String? = nil,
        imdbId: String? = nil,
        productionCompanies: [ProductionCompany]? = nil,
        productionCountries: [ProductionCountry]? = nil,
        revenue: Int? = nil,
        runtime: Int? = nil,
        spokenLanguages: [SpokenLanguage]? = nil,
        status: String? = nil,
        tagline: String? = nil
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
         
        // detail
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.imdbId = imdbId
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
    }
    
}

public extension Movie {
    
    var landscpaeThumbnailUrl: String? {
        getImageUrl(isPortrait: false, isThumb: true)
    }
    
    var landscapeOriginalUrl: String? {
        getImageUrl(isPortrait: false, isThumb: false)
    }
    
    private func getImageUrl(isPortrait: Bool, isThumb: Bool) -> String? {
        
        let imageBaseUrl = "https://image.tmdb.org/t/p/"
        let name = isPortrait ? posterPath : backdropPath
        let size  = isThumb ? "w342" : "original"
        guard let name else { return nil }
        return imageBaseUrl + size + name
        
    }
    
}

extension Movie: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
}
