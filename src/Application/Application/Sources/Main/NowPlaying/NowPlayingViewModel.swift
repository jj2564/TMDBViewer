//
//  NowPlayingViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/15.
//

import Foundation

import Infrastructure_Hosting
import TMDB_Movies_Core

class NowPlayingViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    private var nowPlaying: NowPlaying? = nil
    
    private var loadedPage: Int = 0
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        
    }
    
    
    //MARK: - Properties
    public lazy var moviesRepository: MoviesRepository? = moviesContext?.moviesRepository
    
    public var movieList: [Movie] = []
    
    // bonus info
    public var totalPage: Int? { nowPlaying?.totalPages }
    public var totalResult: Int? { nowPlaying?.totalResults }
    
    
    //MARK: - Methods
    public func loadMore(completion: (() -> Void)?  = nil) {
        
        if loadedPage == totalPage || totalResult == movieList.count { return }
        
        startLoadingView?()
        fetchPlayList(by: loadedPage) { [weak self] _ in
            
            // UI event
            self?.updateView?()
            self?.stopLoadingView?()
            
            // completion
            completion?()
        }
        
    }
    
    private func fetchPlayList(by page: Int, completion: ((Bool) -> Void)?  = nil) {
    
        AsyncHelper().excute { [unowned self] in
            
            try moviesRepository?.findPlayingList(by: page+1)
        } completion: { [weak self] result in
            
            guard let `self` = self else { return }
            guard let result else { return }
            
            // value assign
            self.loadedPage += 1
            self.nowPlaying = result
            
            // figuew
            self.figureResult(result)
            
            // completion
            completion?(true)
        } error: { _ in
            completion?(false)
        }

        
    }
    
    private func figureResult(_ item: NowPlaying) {
        
        movieList = movieList + (item.results ?? [])
    }
    
    
}