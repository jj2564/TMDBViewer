//
//  FavoriteService.swift
//  TMDB.User.Core
//
//  Created by Irving Huang on 2023/8/19.
//

import Foundation

public protocol FavoriteService {
    
    
    //MARK: - Method
    func add(by id: String, data: Data?) throws
    
    func delete(by id: String) throws
    
    func get(by id: String) throws -> Favorite?
    
    func getIdList() throws -> [Favorite]?
}
