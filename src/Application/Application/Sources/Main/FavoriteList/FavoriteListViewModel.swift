//
//  FavoriteListViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

import Infrastructure_Hosting
import TMDB_User_Core
import TMDB_Movies_Core

class FavoriteListViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let userContext: UserContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
    }
    
    
    //MARK: - Properties
    private lazy var favoriteService: FavoriteService? = userContext?.favoriteService
    
    public var movieViewModelList: [MovieCardViewModel] = []
    
    
    //MARK: - Methods
    public func fetchAll() {
        
        startLoadingView?()
        
        fetchFavoriteAll() { [weak self] _ in
            
            self?.stopLoadingView?()
            self?.updateView?()
        }
        
    }
    
    private func fetchFavoriteAll(completion: ((Bool) -> Void)?  = nil) {
        
        AsyncHelper().excute { [unowned self] in
            try favoriteService?.getIdList()
        } completion: { [weak self] list in
            guard let `self` = self else { return }
            guard let list else { return }
            
            let idList = list.compactMap { $0.id }
            self.movieViewModelList = self.generateViewModelList(idList)
            completion?(true)
            
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func generateViewModelList(_ idList: [String]) -> [MovieCardViewModel] {
        
        idList.compactMap {
            let vm = MovieCardViewModel()
            guard let id = Int($0) else { return nil }
            vm.movie = Movie(id: id)
            return vm
        }
        
    }
    
}
