//
//  PhotoSummary.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

public class PhotoSummary: Codable {
    
    public var backdrops: [Photo]?
    public var logos: [Photo]?
    public var posters: [Photo]?
    public var id: Int?
    
}
