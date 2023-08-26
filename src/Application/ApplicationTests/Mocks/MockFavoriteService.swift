//
//  MockFavoriteService.swift
//  ApplicationTests
//
//  Created by Irving Huang on 2023/8/26.
//

import Foundation

import TMDB_User_Core

class MockFavoriteService: FavoriteService {
    
    var mockFavorites: [Favorite] = []
    
    func add(by id: String, data: Data?) throws {
        let favorite = Favorite(id: id, createDate: Date(), data: data)
        mockFavorites.append(favorite)
    }
    
    func delete(by id: String) throws {
        mockFavorites.removeAll { $0.id == id }
    }
    
    func get(by id: String) throws -> Favorite? {
        return mockFavorites.first(where: { $0.id == id })
    }
    
    func getIdList() throws -> [Favorite]? {
        return mockFavorites
    }
    
}
