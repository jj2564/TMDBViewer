//
//  NowPlayingViewModelTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/19.
//

import XCTest

import Infrastructure_Hosting
import TMDB_Movies_Core

@testable import Application


class NowPlayingViewModelTest: XCTestCase {
    
    var viewModel: NowPlayingViewModel!
    var mockMoviesRepository: MockMoviesRepository!
    
    
    override func setUp() {
        super.setUp()
        
        mockMoviesRepository = MockMoviesRepository()
        
        viewModel = NowPlayingViewModel()
        viewModel.moviesRepository = mockMoviesRepository
        
    }
    
    func testLoadMore_WithAvailableMovies_UpdatesMovieList() {
        // 給定
        let movie1 = Movie(title: "Test Movie 1")
        let movie2 = Movie(title: "Test Movie 2")
        
        let mockPlaying = NowPlaying(dates: nil, page: 1, results: [movie1, movie2], totalPages: 1, totalResults: 2)
        mockMoviesRepository.mockNowPlaying = mockPlaying
        
        // 當
        viewModel.loadMore() {
            XCTAssertEqual(self.viewModel.movieList.count, 2)
            
            XCTAssertEqual(self.viewModel.movieList[0].title, "Test Movie 1")
            XCTAssertEqual(self.viewModel.movieList[1].title, "Test Movie 2")
        }
        
        
    }
    
    override func tearDown() {
        viewModel = nil
        mockMoviesRepository = nil
        super.tearDown()
    }
    
}
