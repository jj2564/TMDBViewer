//
//  MockHttpClientProvider.swift
//  TMDB_Movies_AccessesTests
//
//  Created by Irving Huang on 2023/8/26.
//

import Infrastructure_HttpClient


public class MockHttpClientProvider: HttpClientProvider {
    
    // Properties to store mock responses
    var mockGetResponse: HttpResponse?
    var mockPostResponse: HttpResponse?
    
    // Property to store the set token (optional, if you want to verify token setting in tests)
    var setTokenValue: String?
    
    // Initialize with optional default mock responses
    public init(getResponse: HttpResponse? = nil, postResponse: HttpResponse? = nil) {
        self.mockGetResponse = getResponse
        self.mockPostResponse = postResponse
    }
    
    public func get(_ request: HttpRequest) throws -> HttpResponse {
        if let response = mockGetResponse {
            return response
        }
        throw HttpError.networkError("Mocked GET error")
    }
    
    public func post(_ request: HttpRequest) throws -> HttpResponse {
        if let response = mockPostResponse {
            return response
        }
        throw HttpError.networkError("Mocked POST error")
    }
    
    public func setToken(_ token: String) {
        setTokenValue = token
    }
    
}
