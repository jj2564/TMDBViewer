//
//  MovieDetailViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import Foundation

import Infrastructure_Hosting
import TMDB_Movies_Core

class MovieDetailViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
    }
    
    
    //MARK: - Properties
    public lazy var moviesRepository: MoviesRepository? = moviesContext?.moviesRepository
    
    public var movie: Movie? = nil
    
    public var mainImageUrl: String? { movie?.landscapeOriginalUrl }
    public var titleString: String? { movie?.originalTitle }
    
    
    
    //MARK: - Methods
    public func loadMoviewDetail(completion: (() -> Void)?  = nil) {
        
        guard let id = movie?.id else { return }
        
        fetchMovieDeatil(by: id) { [weak self] _ in
            
            self?.updateView?()
            
            //completion
            completion?()
        }
        
    }
    
    private func fetchMovieDeatil(by id: Int, completion: ((Bool) -> Void)?  = nil)  {
        
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
    
}
