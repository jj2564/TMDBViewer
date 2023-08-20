//
//  UserContextFactory.swift
//  TMDB.User.Hosting
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

import Infrastructure_Hosting
import Infrastructure_DataStorage

import TMDB_User_Core
import TMDB_User_Accesses

public class UserContextFactory: ServiceFactory {
    
    
    //MARK: - Constructors
    public init() { }
    
    
    //MARK: - Methods
    public func getService<T>(provider: ServiceProvider) -> T? {
        
        // check
        guard UserContext.self is T.Type else { return nil }
        
        let dataStorage: DataStorage? = provider.getService()
        let favoriteService = DataStorageFavoriteService(dataStorage)
        
        // create
        let context = UserContext(
            favoriteService: favoriteService
        )
        
        // return
        return context as? T
        
    }
}
