//
//  ToggleFavorButtonViewModelTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest

import TMDB_User_Core
import TMDB_Movies_Core

@testable import Application

class ToggleFavorButtonViewModelTest: XCTestCase {
    
    
    var viewModel: ToggleFavorButtonViewModel!
    var mockFavoriteService: MockFavoriteService!
    
    override func setUp() {
        
        super.setUp()
        
        mockFavoriteService = MockFavoriteService()
        
        viewModel = ToggleFavorButtonViewModel()
        viewModel.favoriteService = mockFavoriteService
    }
    
    func testCheckFavor_MovieIsFavorite() {
        
        let expectation = self.expectation(description: "Check favor expectation")

        let movie = Movie(id: 1)
        viewModel.movie = movie
        
        try? mockFavoriteService.add(by: "1", data: nil)
        
        viewModel.checkFavor {

            XCTAssertEqual(self.viewModel.isFavor, true)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testAddFavor_MovieBecomesFavorite() {
        
        let expectation = self.expectation(description: "Add favor expectation")

        let movie = Movie(id: 1)
        viewModel.movie = movie
        
        viewModel.addFavor {
            
            let favorite = try? self.mockFavoriteService.get(by: "1")
            XCTAssertNotNil(favorite)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testDeleteFavor_MovieIsRemovedFromFavorites() {
        
        let expectation = self.expectation(description: "Delete favor expectation")

        let movie = Movie(id: 1)
        viewModel.movie = movie
        
        try? mockFavoriteService.add(by: "1", data: nil)
        
        viewModel.deleteFavor {
            
            let favorite = try? self.mockFavoriteService.get(by: "1")
            XCTAssertNil(favorite)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    override func tearDown() {
        viewModel = nil
        mockFavoriteService = nil
        super.tearDown()
    }
    
}
