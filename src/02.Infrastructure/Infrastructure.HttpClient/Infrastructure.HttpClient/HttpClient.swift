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
    
    public private(set) var sessionString: String = ""
    
    
    //MARK: - Constructors
    public required init(httpClientProvider: HttpClientProvider) {
        self.httpClientProvider = httpClientProvider
        
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
    
    open func setSessionString(_ sessionString: String) {
        self.sessionString = sessionString
    }
    
}

public enum HttpError: Error {
    case networkError(String)
}
