//
//  HttpRequest.swift
//  Infrastructure.HttpClient
//
//  Created by IrvingHuang on 2022/1/13.
//

public typealias HttpHeaders = [String: String]

public struct HttpRequest{
    
    
    //MARK: - Constructors
    public init(url: String, headers: HttpHeaders, content: Data){
        self.url = url
        self.headers = headers
        self.content = content
    }
    
    
    //MARK: - Properties
    public let url: String
    public let headers: HttpHeaders
    public let content: Data
    
}
