//
//  ContextFactoryRegister.swift
//  Application
//
//  Created by Irving Huang on 2023/8/14.
//

import Foundation

// Infrastructure
import Infrastructure_Core
import Infrastructure_Hosting
import Infrastructure_HttpClient_Hosting
import Infrastructure_DataStorage_Hosting

// Application
import TMDB_Movies_Hosting
import TMDB_User_Hosting

class ContextFactoryRegister {
    
    
    public func initialHosting() {
        
        
        // Infrastructure
        HostContext.current.registerFactory(factory: HttpClientFactory(), isSingle: true)
        HostContext.current.registerFactory(factory: DataStorageFactory(), isSingle: true)
        
        // Application
        HostContext.current.registerFactory(factory: MoviesContextFactory(), isSingle: false)
        HostContext.current.registerFactory(factory: UserContextFactory(), isSingle: false)
        
        
    }
    
}
