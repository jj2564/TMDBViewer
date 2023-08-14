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
    
    func findMovie(by id: String) throws -> Movie?
}
