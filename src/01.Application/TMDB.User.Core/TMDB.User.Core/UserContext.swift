//
//  UserContext.swift
//  TMDB.User.Core
//
//  Created by Irving Huang on 2023/8/19.
//

import Foundation

public class UserContext {
    
    
    //MARK: - Constructor
    public required init(
        favoriteService: FavoriteService? = nil
    ) {
        
        self.favoriteService = favoriteService
    }
    
    public private(set) var favoriteService: FavoriteService?
    
}
