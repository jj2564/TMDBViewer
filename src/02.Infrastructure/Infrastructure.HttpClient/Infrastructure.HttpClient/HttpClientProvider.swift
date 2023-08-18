//
//  HttpClientProvider.swift
//  Infrastructure.HttpClient
//
//  Created by IrvingHuang on 2022/1/13.
//

import Foundation

public protocol HttpClientProvider {
    
    func get(_ request: HttpRequest) throws -> HttpResponse
    
    func post(_ request: HttpRequest) throws -> HttpResponse
    
    func setToken(_ token: String)
    
}
