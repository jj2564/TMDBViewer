//
//  AuthRepository.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/22.
//

import Foundation

public protocol AuthRepository {
    
    func authentication(token: String) throws -> Bool?
    
    func authId(apiId: String, sessionId: String) throws -> Bool?
    
    func getRequestToken(apiId: String) throws -> String?
    
    func getSessionId(apiId: String, requestToken: String) throws -> String?
}
