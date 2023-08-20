//
//  MovieDetailViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/19.
//

import Foundation

import Infrastructure_Hosting
import TMDB_Movies_Core
import TMDB_User_Core

class MovieDetailViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    private let userContext: UserContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
    }
    
    
    //MARK: - Properties
    public lazy var moviesRepository: MoviesRepository? = moviesContext?.moviesRepository
    public lazy var favoriteService: FavoriteService? = userContext?.favoriteService
    
    public var movie: Movie? = nil
    
    public var mainImageUrl: String? { movie?.landscapeOriginalUrl }
    public var titleString: String? { movie?.originalTitle }
    
    public var updateFavorite: ((Bool) -> Void)?
    
    
    //MARK: - Methods
    public func loadMoviewDetail(completion: (() -> Void)?  = nil) {
        
        print("irving count")
        guard let id = movie?.id else { return }
        
        fetchMovieDeatil(by: id) { [weak self] _ in
            
            self?.updateView?()
            
            //completion
            completion?()
        }
        
        fetchFavorite(by: id) { [weak self] isFavor in
            self?.updateFavorite?(isFavor)
        }
        
    }
    
    public func addFavor() {
        
        guard let id = movie?.id else { return }
        
        self.addFavorite(by: id) { [weak self] isFavor in
            self?.updateFavorite?(isFavor)
        }
        
    }
    
    public func deleteFavor() {
        guard let id = movie?.id else { return }
        
        self.deleteFavorite(by: id) { [weak self] isFavor in
            self?.updateFavorite?(isFavor)
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
    
    private func addFavorite(by id: Int, completion: ((Bool) -> Void)? = nil) {
        
        let idString = "\(id)"
        
        AsyncHelper().excute { [unowned self] in
            try favoriteService?.add(by: idString)
        } completion: { _ in
            completion?(true)
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func deleteFavorite(by id: Int, completion: ((Bool) -> Void)? = nil) {
        
        let idString = "\(id)"
        
        AsyncHelper().excute { [unowned self] in
            try favoriteService?.delete(by: idString)
        } completion: { _ in
            completion?(false)
        } error: { _ in
            completion?(true)
        }
        
    }
    
    private func fetchFavorite(by id: Int, completion: ((Bool) -> Void)? = nil) {
        
        let idString = "\(id)"
        
        AsyncHelper().excute { [unowned self] in
            try favoriteService?.get(by: idString)
        } completion: { _ in
            completion?(true)
        } error: { _ in
            completion?(false)
        }
        
    }
    
}
