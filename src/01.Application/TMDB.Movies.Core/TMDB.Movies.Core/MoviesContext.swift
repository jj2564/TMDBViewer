//
//  MoviesContext.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation


public class MoviesContext {
    
    
    //MARK: - Constructor
    public required init(
        moviesRepository: MoviesRepository? = nil
    ) {
        self.moviesRepository = moviesRepository
    }
    
    public private(set) var moviesRepository: MoviesRepository?
    
}
