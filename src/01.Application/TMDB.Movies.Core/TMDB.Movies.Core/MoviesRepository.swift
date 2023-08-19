//
//  MoviesRepository.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation

public protocol MoviesRepository {
    
    
    //MARK: - Method
    func findPlayingList(by page: Int) throws -> NowPlaying?
    
    func findMovieDetail(by id: String) throws -> Movie?
}

public extension MoviesRepository {
    
    func findPlayingList(by page: Int) throws -> NowPlaying? { nil }
    
    func findMovieDetail(by id: String) throws -> Movie? { nil }
}
