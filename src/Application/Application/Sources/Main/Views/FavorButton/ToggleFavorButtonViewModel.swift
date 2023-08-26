//
//  ToggleFavorButtonViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

import Infrastructure_Hosting
import Infrastructure_HttpClient
import TMDB_User_Core
import TMDB_Movies_Core

class ToggleFavorButtonViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let userContext: UserContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
    }
    
    
    //MARK: - Properties
    public lazy var favoriteService: FavoriteService? = userContext?.favoriteService
    
    public var movie: Movie? = nil {
        didSet { checkFavor() }
    }
    
    public var movieId: Int? {
        movie?.id
    }
    
    public var isFavor: Bool = false
    
    public var updateFavorite: ((Bool) -> Void)?
    
    
    //MARK: - Methods
    public func checkFavor(completion: (() -> Void)?  = nil) {
        
        guard let id = movieId else { return }
        
        fetchFavorite(by: id) { [weak self] isFavor in
            self?.isFavor = isFavor
            self?.updateFavorite?(isFavor)
            completion?()
        }
        
    }
    
    public func addFavor(completion: (() -> Void)?  = nil) {
        
        guard let id = movieId else { return }
        
        self.addFavorite(by: id) { [weak self] isFavor in
            self?.isFavor = true
            self?.updateFavorite?(isFavor)
            completion?()
        }
        
    }
    
    public func deleteFavor(completion: (() -> Void)?  = nil) {
        guard let id = movieId else { return }
        
        self.deleteFavorite(by: id) { [weak self] isFavor in
            self?.isFavor = false
            self?.updateFavorite?(isFavor)
            completion?()
        }
        
    }
    
    private func addFavorite(by id: Int, completion: ((Bool) -> Void)? = nil) {
        
        let idString = "\(id)"
        
        var data: Data? = nil
        if let movie, let movieData = try? jsonData(encodable: movie) {
            data = movieData
        }
        
        AsyncHelper().excute { [unowned self] in
            try favoriteService?.add(by: idString, data: data)
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
