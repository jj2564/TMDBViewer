//
//  NowPlayingTests.swift
//  TMDB_Movies_AccessesTests
//
//  Created by Irving Huang on 2023/8/17.
//

import XCTest

import Infrastructure_HttpClient
import Infrastructure_HttpClient_Curl

import TMDB_Movies_Accesses

class MockHttpClient: HttpClient {
    var mockResponse: HttpResponse?
    
    override func get(_ request: HttpRequest) throws -> HttpResponse {
        if let response = mockResponse {
            return response
        }
        throw HttpError.networkError("Mocked error")
    }
}

class NowPlayingTests: XCTestCase {
    
    func testFindPlayingListSuccess() throws {
        
        let provider = CurlHttpClientProvider()
        
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
    
}


