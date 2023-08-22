//
//  AuthRepository.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/22.
//

import Foundation

public protocol AuthRepository {
    
    func authentication(token: String) throws -> Bool?
}
