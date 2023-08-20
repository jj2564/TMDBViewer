//
//  Favorite.swift
//  TMDB.User.Core
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

public class Favorite: Codable {
    
    public var id: String!
    public var createDate: Date!
    
    public init(
        id: String,
        createDate: Date
    ) {
        self.id = id
        self.createDate = createDate
    }
    
}
