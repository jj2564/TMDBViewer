//
//  RestPhotoRepositoryTests.swift
//  TMDB_Movies_AccessesTests
//
//  Created by Irving Huang on 2023/8/26.
//

import XCTest

import Infrastructure_HttpClient

import TMDB_Movies_Accesses

class RestPhotoRepositoryTests: XCTestCase {

    let provider = MockHttpClientProvider()
    
    func testFindPhotoSummary() throws {
        
        // create mock
        let mockHttpClient = MockHttpClient(httpClientProvider: provider)
        
        let mockResponseData = """
        {
          "id": 1234,
          "backdrops": [
            {
              "aspect_ratio": 1.77,
              "file_path": "/mockBackdrop.jpg",
              "width": 1280,
              "height": 720
            }
          ],
          "posters": [
            {
              "aspect_ratio": 1.5,
              "file_path": "/mockPoster.jpg",
              "width": 500,
              "height": 750
            }
          ]
        }
        """.data(using: .utf8)!
        
        let httpResponse = HttpResponse(content: mockResponseData, statusCode: 200)
        mockHttpClient.mockResponse = httpResponse
        
        let repository = RestPhotoRepository(mockHttpClient)
        let result = try? repository.findSummary(by: 1234)
        
        // Validate result
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, 1234)
        XCTAssertEqual(result?.backdrops?.first?.filePath, "/mockBackdrop.jpg")
        XCTAssertEqual(result?.posters?.first?.filePath, "/mockPoster.jpg")
        
    }
    
}
