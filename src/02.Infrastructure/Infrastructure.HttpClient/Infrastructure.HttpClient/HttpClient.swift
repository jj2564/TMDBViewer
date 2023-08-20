//
//  HttpClient.swift
//  Infrastructure.HttpClient
//
//  Created by IrvingHuang on 2022/1/13.
//

import Foundation

open class HttpClient {
    
    
    //MARK: - Fields
    public private(set) var httpClientProvider: HttpClientProvider!
    
    public private(set) var serviceUrl: String = ""
    
    
    //MARK: - Constructors
    public required init(httpClientProvider: HttpClientProvider) {
        self.httpClientProvider = httpClientProvider
        
        iso8601Formatter.formatOptions = [.withFullDate]
        iso8601FormatterFull.formatOptions = [.withColonSeparatorInTime]
    }
    
    
    //MARK: - Methods
    open func get(_ request: HttpRequest) throws -> HttpResponse {
        try httpClientProvider.get(request)
    }
    
    open func post(_ request: HttpRequest) throws -> HttpResponse {
        try httpClientProvider.post(request)
    }
    
    open func setToken(_ token: String) {
        httpClientProvider.setToken(token)
    }
    
    open func setServiceUrl(_ urlString: String) {
        self.serviceUrl = urlString
    }
    
}

public enum HttpError: Error {
    case networkError(String)
}
