//
//  MovieCardViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/16.
//

import Foundation

import Infrastructure_Hosting
import TMDB_Movies_Core

class MovieCardViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
    }
    
    
    //MARK: - Properties
    public var movie: Movie? = nil {
        didSet { updateValue() }
    }
    
    public var imageUrl: String? = nil
    public var name: String? = nil
    public var date: Date? = nil
    public var summary: String? = nil
    
    
    //MARK: - Methods
    public func fetchData(completion: ((Bool) -> Void)?  = nil) {
        
        guard let id = movie?.id else { return }
        
    }
    
    private func fetchMovie(by id: Int, completion: ((Bool) -> Void)?  = nil) {
        
    }
    
    private func updateValue() {
        imageUrl = movie?.landscpaeThumbnailUrl
        name = movie?.originalTitle
        date = movie?.releaseDate
        summary = movie?.overview
    }
    
}
