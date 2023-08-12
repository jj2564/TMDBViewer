//
//  HttpResponse.swift
//  Infrastructure.HttpClient
//
//  Created by IrvingHuang on 2022/1/13.
//

import CoreGraphics

public struct HttpResponse {
    
    
    //MARK: - Constructors
    public init(content: Data, statusCode: Int) {
        self.content = content
        self.statusCode = statusCode
    }
    
    
    //MARK: - Properties
    public let content: Data
    public let statusCode: Int
    
    
}
