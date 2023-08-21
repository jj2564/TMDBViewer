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
    public var data: Data?
    
    public init(
        id: String,
        createDate: Date,
        data: Data?
    ) {
        self.id = id
        self.createDate = createDate
        self.data = data
    }
    
}
