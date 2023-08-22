//
//  RestAuthRepository.swift
//  TMDB.Movies.Accesses
//
//  Created by Irving Huang on 2023/8/22.
//

import Foundation

import Infrastructure_Core
import Infrastructure_HttpClient

import TMDB_Movies_Core


public class RestAuthRepository: AuthRepository {
    
    
    //MARK: - Fields
    private var httpClient: HttpClient?
    
    
    //MARK: - Constructors
    public init(_ httpClient: HttpClient?) {
        self.httpClient = httpClient
    }
    
    
    //MARK: - Properties
    public func authentication(token: String) throws -> Bool? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        let url = service + "authentication"
        
        httpClient?.setToken(token)
        
        // respone
        let response = try getResponse(httpClient, url: url)
        let result = try authResult(data: response.content)
        
        return result.success
    }
    
    
}

struct authResult: Codable {
    
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?
}
