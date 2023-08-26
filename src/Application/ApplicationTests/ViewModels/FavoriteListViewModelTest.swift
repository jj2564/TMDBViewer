//
//  FavoriteListViewModelTest.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest

import TMDB_User_Core
import TMDB_Movies_Core

@testable import Application

class FavoriteListViewModelTest: XCTestCase {
    
    var viewModel: FavoriteListViewModel!
    var mockFavoriteService: MockFavoriteService!
    var mockSettingService: MockSettingService!
    
    override func setUp() {
        super.setUp()
        
        mockFavoriteService = MockFavoriteService()
        mockSettingService = MockSettingService()
        
        viewModel = FavoriteListViewModel()
        viewModel.favoriteService = mockFavoriteService
        viewModel.settingService = mockSettingService
        
    }
    
    func testFetchAll_WithAvailableFavorites_UpdatesMovieList() {
        
        let expectation = self.expectation(description: "Fetch favor expectation")
        
        let favorite1 = Favorite(id: "1", createDate: Date(), data: nil)
        let favorite2 = Favorite(id: "2", createDate: Date().addingTimeInterval(-1000), data: nil)
        
        mockFavoriteService.mockFavorites = [favorite1, favorite2]
        
        viewModel.fetchAll {
            
            XCTAssertEqual(self.viewModel.movieViewModelList.count, 2)
            XCTAssertEqual(self.viewModel.movieViewModelList.first?.movie?.id, 1)
            XCTAssertEqual(self.viewModel.movieViewModelList.last?.movie?.id, 2)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testUpdateSort_SortsMovieList() {

        let movie1 = Movie(id: 1, releaseDate: Date(timeIntervalSince1970: 10000), title: "A")
        let movie2 = Movie(id: 2, releaseDate: Date(timeIntervalSince1970: 20000), title: "B")
        let movie3 = Movie(id: 3, releaseDate: Date(timeIntervalSince1970: 5000), title: "C")
        
        let vm1 = MovieCardViewModel()
        vm1.movie = movie1
        let vm2 = MovieCardViewModel()
        vm2.movie = movie2
        let vm3 = MovieCardViewModel()
        vm3.movie = movie3
        
        viewModel.movieViewModelList = [vm1, vm2, vm3]
        viewModel.sortBy = .releaseDate
        
        viewModel.updateSort()
        
        XCTAssertEqual(viewModel.showList[0].movie?.title, "B")
        XCTAssertEqual(viewModel.showList[1].movie?.title, "A")
        XCTAssertEqual(viewModel.showList[2].movie?.title, "C")
        
    }
    
    override func tearDown() {
        viewModel = nil
        mockFavoriteService = nil
        mockSettingService = nil
        super.tearDown()
    }
    
}
