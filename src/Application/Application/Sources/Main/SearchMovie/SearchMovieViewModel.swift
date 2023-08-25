//
//  SearchMovieViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

import Infrastructure_Hosting
import TMDB_Movies_Core

class SearchMovieViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    
    
    //MARK: - Properties
    public lazy var moviesRepository: MoviesRepository? = moviesContext?.moviesRepository
    
    public var movieList: [Movie] = []
    
    public var queryText: String? = nil
    
    
    // barItem viewModel
    public let layoutViewModel = ToggleLayoutButtonViewModel()
    
    public var perRowCount: Int { layoutViewModel.currentCount }
    
    
    //MARK: - Methods
    public func search(by query: String, completion: (() -> Void)?  = nil) {
        
        movieList = []
        updateView?()
        
        queryText = query
        startLoadingView?()
        
        searchMovie(by: query) { [weak self] _ in
            
            // UI event
            self?.updateView?()
            self?.stopLoadingView?()
            
            // completion
            completion?()
        }
        
    }
    
    
    private func searchMovie(by text: String, completion: ((Bool) -> Void)?  = nil) {
        
    
        AsyncHelper().excute { [unowned self] in
            try moviesRepository?.find(by: text)
        } completion: { [weak self] result in

            guard let `self` = self else { return }
            guard let list = result?.results else { return }

            // value assign
            self.movieList = list

            // completion
            completion?(true)
        } error: { _ in
            completion?(false)
        }

    }
    
}
