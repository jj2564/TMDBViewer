//
//  MovieDetail.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation


public class Genre: Codable {
    
    public var id: Int?
    public var name: String?
    
    public init(
        id: Int? = nil,
        name: String? = nil
    ) {
        self.id = id
        self.name = name
    }
    
}

public class ProductionCompany: Codable {
    
    public var id: Int?
    public var name: String?
    public var originCountry: String?
    
    public init(
        id: Int? = nil,
        name: String? = nil,
        originCountry: String? = nil
    ) {
        self.id = id
        self.name = name
        self.originCountry = originCountry
    }
    
}

public class ProductionCountry: Codable {
    
    public var iso31661: String?
    public var name: String?
    
    public init(
        iso31661: String? = nil,
        name: String? = nil
    ) {
        self.iso31661 = iso31661
        self.name = name
    }
    
}

public class SpokenLanguage: Codable {
    
    public var englishName: String?
    public var iso6391: String?
    public var name: String?
    
    public init(
        englishName: String? = nil,
        iso6391: String? = nil,
        name: String? = nil
    ) {
        self.englishName = englishName
        self.iso6391 = iso6391
        self.name = name
    }
    
}
