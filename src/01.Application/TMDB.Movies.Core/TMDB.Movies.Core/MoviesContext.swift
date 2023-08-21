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
        moviesRepository: MoviesRepository? = nil,
        photosRepository: PhotosRepository? = nil
    ) {
        self.moviesRepository = moviesRepository
        self.photosRepository = photosRepository
    }
    
    public private(set) var moviesRepository: MoviesRepository?
    public private(set) var photosRepository: PhotosRepository?
    
}
