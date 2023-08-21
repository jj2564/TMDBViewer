//
//  Photo.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

public class Photo: Codable {
    
    public var aspectRatio: Double?
    public var height: Int?
    public var iso6391: String?
    public var filePath: String?
    public var voteAverage: Double?
    public var voteCount: Int?
    public var width: Int?
    
    public init(
        aspectRatio: Double? = nil,
        height: Int? = nil,
        iso6391: String? = nil,
        filePath: String? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        width: Int? = nil
    ) {
        self.aspectRatio = aspectRatio
        self.height = height
        self.iso6391 = iso6391
        self.filePath = filePath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.width = width
    }
    
}
