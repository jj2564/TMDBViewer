//
//  MoviesRepository.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation

public protocol MoviesRepository {
    
    
    //MARK: - Method
    func findPlayingList(by page: Int) throws -> MovieListSummary?
    
    func findMovieDetail(by id: String) throws -> Movie?
    
    func find(by query: String) throws -> MovieListSummary?
    
}

public extension MoviesRepository {
    
    func findPlayingList(by page: Int) throws -> MovieListSummary? { nil }
    
    func findMovieDetail(by id: String) throws -> Movie? { nil }
    
    func find(by query: String) throws -> MovieListSummary? { nil }
    
}
