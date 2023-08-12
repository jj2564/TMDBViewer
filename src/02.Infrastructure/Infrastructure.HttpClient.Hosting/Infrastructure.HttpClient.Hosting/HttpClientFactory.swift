//
//  HttpClient.swift
//  Infrastructure.HttpClient.Hosting
//
//  Created by IrvingHuang on 2022/1/13.
//

import Foundation
import Infrastructure_Hosting
import Infrastructure_HttpClient
import Infrastructure_HttpClient_Curl

public class HttpClientFactory: ServiceFactory {

    
    //MARK: - Constructors
    public init() { }
    
    
    //MARK: - Methods
    public func getService<T>(provider: ServiceProvider) -> T? {
        
        // check
        guard HttpClient.self is T.Type else { return nil }
        
        // create
        let curl = CurlHttpClientProvider()
        
        let client = HttpClient(httpClientProvider: curl)
        
        return client as? T
        
    }
    
}
