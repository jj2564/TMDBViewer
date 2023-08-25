//
//  FavoriteListViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

import Infrastructure_Hosting
import Infrastructure_HttpClient
import TMDB_User_Core
import TMDB_Movies_Core

class FavoriteListViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let userContext: UserContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        fetchUserSortStyle()
        
        layoutViewModel.didUpdateRowCount = { [weak self] _ in
            self?.updateView?()
        }
    }
    
    
    //MARK: - Properties
    private lazy var favoriteService: FavoriteService? = userContext?.favoriteService
    private lazy var settingService: SettingService? = userContext?.settingService
    
    public var movieViewModelList: [MovieCardViewModel] = [] {
        didSet { updateSort() }
    }
    
    public var sortBy: MovieCardSortStyle = .releaseDate
    public var showList: [MovieCardViewModel] = []
    
    // barItem viewModel
    public let layoutViewModel = ToggleLayoutButtonViewModel()
    
    public var perRowCount: Int { layoutViewModel.currentCount }
    
    
    //MARK: - Methods
    public func fetchAll() {
        
        startLoadingView?()
        
        fetchFavoriteAll() { [weak self] _ in
            
            self?.stopLoadingView?()
            self?.updateView?()
        }
        
    }
    
    public func updateSort() {
        
        // record
        try? settingService?.set(key: "MovieCardSortStyle", value: sortBy.rawValue)
        
        // sort
        showList = movieViewModelList.sorted(by: sortBy.sortStrategy.sort)
        
        // update
        updateView?()
    }
    
    private func fetchUserSortStyle() {
        
        if let value = try?  settingService?.get(key: "MovieCardSortStyle"), let sortStyle = MovieCardSortStyle(rawValue: value) {
            self.sortBy = sortStyle
        }
        
    }
    
    private func fetchFavoriteAll(completion: ((Bool) -> Void)?  = nil) {
        
        AsyncHelper().excute { [unowned self] in
            try favoriteService?.getIdList()
        } completion: { [weak self] list in
            guard let `self` = self else { return }
            guard let list else { return }
            
            self.movieViewModelList = self.generateViewModelList(list)
            completion?(true)
            
        } error: { _ in
            completion?(false)
        }
        
    }
    
    private func generateViewModelList(_ favorList: [Favorite]) -> [MovieCardViewModel] {
        
        favorList.compactMap {
            let vm = MovieCardViewModel()
            if let data = $0.data, let movie = try? Movie(data: data) {
                vm.movie = movie
            } else if let id = Int($0.id) {
                vm.movie = Movie(id: id)
            } else { return nil }
            
            return vm
        }
        
    }
    
}
