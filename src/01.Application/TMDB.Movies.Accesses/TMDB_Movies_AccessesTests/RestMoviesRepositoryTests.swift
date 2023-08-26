//
//  RestMoviesRepositoryTests.swift
//  TMDB_Movies_AccessesTests
//
//  Created by Irving Huang on 2023/8/17.
//

import XCTest

import Infrastructure_HttpClient

import TMDB_Movies_Accesses

class RestMoviesRepositoryTests: XCTestCase {
    
    let provider = MockHttpClientProvider()
    
    func testFindPlayingListSuccess() throws {
        
        // create mock
        let mockHttpClient = MockHttpClient(httpClientProvider: provider)
        
        let mockResponseData = """
        {
          "dates": {
            "maximum": "2023-08-22",
            "minimum": "2023-07-05"
          },
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/mock.jpg",
              "genre_ids": [
                1,2,3
              ],
              "id": 1001,
              "original_language": "en",
              "original_title": "Mock Name",
              "overview": "A mock movie for unit test",
              "popularity": 1.0,
              "poster_path": "/mock.jpg",
              "release_date": "2023-08-18",
              "title": "Mock Name",
              "video": false,
              "vote_average": 9.9,
              "vote_count": 999
            }
          ],
          "total_pages": 1,
          "total_results": 1
        }
        """.data(using: .utf8)!
        
        let httpResponse = HttpResponse(content: mockResponseData, statusCode: 200)
        mockHttpClient.mockResponse = httpResponse

        
        let repository = RestMoviesRepository(mockHttpClient)
        let result = try? repository.findPlayingList(by: 1)
        
        // Validate result
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.page, 1)
        XCTAssertEqual(result?.results?.first?.title, "Mock Name")
    }
    
    func testFindMovie() throws {
        
        // create mock
        let mockHttpClient = MockHttpClient(httpClientProvider: provider)
        
        let mockResponseData = """
        {
            "adult": false,
            "backdrop_path": "/mock.jpg",
            "genre_ids": [
            1,2,3
            ],
            "id": 1001,
            "original_language": "en",
            "original_title": "Mock Name",
            "overview": "A mock movie for unit test",
            "popularity": 1.0,
            "poster_path": "/mock.jpg",
            "release_date": "2023-08-18",
            "title": "Mock Name",
            "video": false,
            "vote_average": 9.9,
            "vote_count": 999,
            "imdb_id": "tt0001",
            "spoken_languages": [
                {
                "english_name": "Japanese",
                "iso_639_1": "ja",
                "name": "日本語"
                }
            ]
        }
        """.data(using: .utf8)!

        
        let httpResponse = HttpResponse(content: mockResponseData, statusCode: 200)
        mockHttpClient.mockResponse = httpResponse
        
        let repository = RestMoviesRepository(mockHttpClient)
        
        let result = try? repository.findMovieDetail(by: "1001")
        
        // Validate result
        XCTAssertNotNil(result)
        // movie part
        XCTAssertEqual(result?.id, 1001)

        // detail part
        XCTAssertEqual(result?.imdbId, "tt0001")
        XCTAssertEqual(result?.spokenLanguages?.first?.name, "日本語")
    }
    
    func testFindMoviesByQuery() throws {
        
        // create mock
        let mockHttpClient = MockHttpClient(httpClientProvider: provider)
        
        // Assuming a mock response for a search query "mockquery"
        let mockResponseData = """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/mock.jpg",
              "genre_ids": [
                1,2,3
              ],
              "id": 1002,
              "original_language": "en",
              "original_title": "Mock Search Name",
              "overview": "A mock movie for unit test from search",
              "popularity": 1.1,
              "poster_path": "/mocksearch.jpg",
              "release_date": "2023-08-19",
              "title": "Mock Search Name",
              "video": false,
              "vote_average": 9.8,
              "vote_count": 998
            }
          ],
          "total_pages": 1,
          "total_results": 1
        }
        """.data(using: .utf8)!
        
        let httpResponse = HttpResponse(content: mockResponseData, statusCode: 200)
        mockHttpClient.mockResponse = httpResponse
        
        let repository = RestMoviesRepository(mockHttpClient)
        let result = try? repository.find(by: "mockquery")
        
        // Validate result
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.page, 1)
        XCTAssertEqual(result?.results?.first?.title, "Mock Search Name")
        
    }
    
}


