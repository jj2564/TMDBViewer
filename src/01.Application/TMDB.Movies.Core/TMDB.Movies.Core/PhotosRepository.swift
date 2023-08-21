//
//  PhotosRepository.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

public protocol PhotosRepository {
    
    func findSummary(by movieId: Int) throws -> PhotoSummary?
    
}

public extension PhotosRepository {
    
    func findSummary(by movieId: Int) throws -> PhotoSummary? { nil }
    
}
