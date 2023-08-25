//
//  MockMovieRepository.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/19.
//

import Foundation

import TMDB_Movies_Core

class MockMoviesRepository: MoviesRepository {
    
    var mockNowPlaying: MovieListSummary?
    
    func findPlayingList(by page: Int) throws -> MovieListSummary? {
        return mockNowPlaying
    }
    
    func findMovieDetail(by id: String) throws -> Movie? {
        nil
    }
    
}
