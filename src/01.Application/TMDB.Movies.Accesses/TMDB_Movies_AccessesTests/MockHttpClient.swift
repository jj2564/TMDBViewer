//
//  MockHttpClient.swift
//  TMDB_Movies_AccessesTests
//
//  Created by Irving Huang on 2023/8/26.
//

import Infrastructure_HttpClient


class MockHttpClient: HttpClient {
    var mockResponse: HttpResponse?
    
    override func get(_ request: HttpRequest) throws -> HttpResponse {
        if let response = mockResponse {
            return response
        }
        throw HttpError.networkError("Mocked error")
    }
}
