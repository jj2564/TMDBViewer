//
//  MoviesContextFactory.swift
//  TMDB.Movies.Hosting
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation

import Infrastructure_Hosting
import Infrastructure_HttpClient

import TMDB_Movies_Core
import TMDB_Movies_Accesses

public class MoviesContextFactory: ServiceFactory {
    
    
    //MARK: - Constructors
    public init() { }
    
    
    //MARK: - Methods
    public func getService<T>(provider: ServiceProvider) -> T? {
        
        // check
        guard MoviesContext.self is T.Type else { return nil }
        
        let httpClient: HttpClient? = provider.getService()
        
        let moviesRepository = RestMoviesRepository(httpClient)
        
        let context = MoviesContext(
            moviesRepository: moviesRepository
        )
        
        // return
        return context as? T
        
    }
    
}
