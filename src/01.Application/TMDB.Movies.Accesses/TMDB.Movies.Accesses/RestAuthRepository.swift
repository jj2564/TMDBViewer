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
        let result = try AuthResult(data: response.content)
        
        return result.success
    }
    
    public func authId(apiId: String, sessionId: String) throws -> Bool? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        let sessionString = "api_key=\(apiId)&session_id=\(sessionId)"
        let url = service + "account?" + sessionString
        
        let response = try getResponse(httpClient, url: url)
        let dictionary = response.content.dictionary
        
        if let _ = dictionary?["status_code"] as? Int {
            return false
        } else if let _ = dictionary?["id"] as? Int {
            
            httpClient?.setSessionString(sessionString)
            return true
        }
        
        return false
        
    }
    
    public func getRequestToken(apiId: String) throws -> String? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        let url = service + "authentication/token/new?api_key=" + apiId
        
        // respone
        let response = try getResponse(httpClient, url: url)
        let result = try RequsetTokenResult(data: response.content)

        
        return result.requestToken
    }
    
    public func getSessionId(apiId: String, requestToken: String) throws -> String? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        let url = service + "authentication/session/new?api_key=" + apiId
        
        let parameters: JSONDictionary = [
            "request_token": requestToken
        ]
        
        // respone
        let response = try postResponse(httpClient, url: url, dictionary: parameters)
        let result = try SessionIdResult(data: response.content)
        
        if let sessionId = result.sessionId {
            let sessionString = "api_key=\(apiId)&session_id=\(sessionId)"
            httpClient?.setSessionString(sessionString)
        }
        
        return result.sessionId
        
    }
    
    
}

struct AuthResult: Codable {
    
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?
}

struct RequsetTokenResult: Codable {
    
    var success: Bool?
    var requestToken: String?
    
}

struct SessionIdResult: Codable {
    
    var success: Bool?
    var sessionId: String?
}
