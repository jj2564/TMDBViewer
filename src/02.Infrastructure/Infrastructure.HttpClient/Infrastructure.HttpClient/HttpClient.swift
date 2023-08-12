//
//  HttpClient.swift
//  Infrastructure.HttpClient
//
//  Created by IrvingHuang on 2022/1/13.
//

import Foundation

public class HttpClient {
    
    
    //MARK: - Fields
    public private(set) var httpClientProvider: HttpClientProvider!
    
    
    //MARK: - Constructors
    public required init(httpClientProvider: HttpClientProvider) {
        self.httpClientProvider = httpClientProvider
    }
    
    
    //MARK: - Methods
    public func get(_ request: HttpRequest) throws -> HttpResponse {
        try httpClientProvider.get(request)
    }
    
    public func post(_ request: HttpRequest) throws -> HttpResponse {
        try httpClientProvider.post(request)
    }
    
    public func setToken(_ token: String) {
        httpClientProvider.setToken(token)
    }
    
}

public enum HttpError: Error {
    case networkError(String)
}
