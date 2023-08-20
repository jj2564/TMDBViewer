//
//  ToggleFavorButtonViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

import Infrastructure_Hosting
import TMDB_User_Core

class ToggleFavorButtonViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let userContext: UserContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
    }
    
    
    //MARK: - Properties
    public lazy var favoriteService: FavoriteService? = userContext?.favoriteService
    
    public var movieId: Int? = nil {
        didSet { checkFavor() }
    }
    
    public var updateFavorite: ((Bool) -> Void)?
    
    
    //MARK: - Methods
    public func checkFavor(completion: (() -> Void)?  = nil) {
        
        guard let id = movieId else { return }
        
        fetchFavorite(by: id) { [weak self] isFavor in
            self?.updateFavorite?(isFavor)
            completion?()
        }
        
    }
    
    public func addFavor() {
        
        guard let id = movieId else { return }
        
        self.addFavorite(by: id) { [weak self] isFavor in
            self?.updateFavorite?(isFavor)
        }
        
    }
    
    public func deleteFavor() {
        guard let id = movieId else { return }
        
        self.deleteFavorite(by: id) { [weak self] isFavor in
            self?.updateFavorite?(isFavor)
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
