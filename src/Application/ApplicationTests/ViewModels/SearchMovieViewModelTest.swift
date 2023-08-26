//
//  SearchMovieViewModelTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest

import TMDB_Movies_Core

@testable import Application

class SearchMovieViewModelTest: XCTestCase {
    
    var viewModel: SearchMovieViewModel!
    var mockMoviesRepository: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        
        mockMoviesRepository = MockMoviesRepository()
        
        viewModel = SearchMovieViewModel()
        viewModel.moviesRepository = mockMoviesRepository
        
    }
    
    func testSearch_WithQuery_ReturnsMovieList() {

        let expectation = self.expectation(description: "Search query expectation")
        
        let movie1 = Movie(title: "Test Movie 1")
        let movie2 = Movie(title: "Test Movie 2")
        
        let mockQueryList = MovieListSummary(dates: nil, page: 1, results: [movie1, movie2], totalPages: 1, totalResults: 2)
        mockMoviesRepository.mockQueryList = mockQueryList
        
        viewModel.search(by: "Test") {
            XCTAssertEqual(self.viewModel.movieList.count, 2)
            XCTAssertEqual(self.viewModel.movieList[0].title, "Test Movie 1")
            XCTAssertEqual(self.viewModel.movieList[1].title, "Test Movie 2")
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
