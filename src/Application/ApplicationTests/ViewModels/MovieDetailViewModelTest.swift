//
//  MovieDetailViewModelTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest

import TMDB_Movies_Core

@testable import Application

class MovieDetailViewModelTest: XCTestCase {
    
    var viewModel: MovieDetailViewModel!
    var mockMoviesRepository: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        
        mockMoviesRepository = MockMoviesRepository()
        
        viewModel = MovieDetailViewModel()
        viewModel.moviesRepository = mockMoviesRepository
    }
    
    func testLoadMovieDetail_ReturnsDetail() {
        
        let expectation = self.expectation(description: "Detail expectation")
        
        let mockMovie = Movie(id: 123, originalTitle: "Test Movie Detail")
        mockMoviesRepository.mockMovieDetail = mockMovie
        
        viewModel.movie = mockMovie

        viewModel.loadMoviewDetail {
            XCTAssertEqual(self.viewModel.titleString, "Test Movie Detail")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    override func tearDown() {
        viewModel = nil
        mockMoviesRepository = nil
        super.tearDown()
    }
    
}
