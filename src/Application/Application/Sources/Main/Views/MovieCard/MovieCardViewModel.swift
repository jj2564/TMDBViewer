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
    public lazy var moviesRepository: MoviesRepository? = moviesContext?.moviesRepository
    
    public let favorButtonViewModel = ToggleFavorButtonViewModel()
    
    public var movie: Movie? = nil {
        didSet { updateValue() }
    }
    
    public var movieId: Int? = nil
    public var imageUrl: String? = nil
    public var name: String? = nil
    public var date: Date? = nil
    public var summary: String? = nil
    
    
    //MARK: - Methods
    public func fetchData(completion: (() -> Void)?  = nil) {
        
        guard movie?.originalTitle.isNil == true else { return }
        guard let id = movie?.id else { return }
        
        fetchMovieDeatil(by: id) { [weak self] _ in
            
            self?.updateValue()
            self?.updateView?()
            
            //completion
            completion?()
        }
        
        
    }
    
    private func fetchMovieDeatil(by id: Int, completion: ((Bool) -> Void)?  = nil) {
        
        let idString = "\(id)"
        
        AsyncHelper().excute { [unowned self] in
            try moviesRepository?.findMovieDetail(by: idString)
        } completion: { [weak self] result in
            
            guard let `self` = self else { return }
            guard let result else { return }
            
            self.movie = result
            
            completion?(true)
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func updateValue() {
        imageUrl = movie?.landscpaeThumbnailUrl
        name = movie?.originalTitle
        date = movie?.releaseDate
        summary = movie?.overview
        movieId = movie?.id
        
        favorButtonViewModel.movie = movie
    }
    
}
