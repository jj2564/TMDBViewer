//
//  KFImageContainerViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

import Infrastructure_Hosting
import TMDB_Movies_Core

class KFImageContainerViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    private let moviesContext: MoviesContext? = HostContext.current.getService()
    
    private var photoSummary: PhotoSummary? = nil
    
    
    //MARK: - Constructors
    required init() {
        super.init()
        
    }
    
    
    //MARK: - Properties
    public lazy var photosRepository: PhotosRepository? = moviesContext?.photosRepository
    
    public var imageUrlString: String? = nil
    
    public var movieId: Int? = nil
    
    public var isLandscape: Bool = true
    
    
    //MARK: - Methods
    private func loadPhotoInfo(completion: ((Bool) -> Void)?  = nil) {
        
        guard let movieId else { return }
        
        fetchPhotoSummary(movieId: movieId) { [weak self] success in
            
            if success {
                self?.updateView?()
            }
            
        }
        
    }
    
    private func fetchPhotoSummary(movieId: Int, completion: ((Bool) -> Void)?  = nil) {
        
        AsyncHelper().excute { [unowned self] in
            try photosRepository?.findSummary(by: movieId)
        } completion: { [weak self] result in
            
            guard let `self` = self else { return }
            guard let result else { return }
            
            self.photoSummary = result
            let canReload = self.figureSecondPath()
            
            // completion
            if canReload {
                completion?(true)
            } else {
                completion?(false)
            }
        } error: { _ in
            completion?(false)
        }

        
    }
    
    private func figureSecondPath() -> Bool {
        
        if isLandscape {
            
            guard let path = photoSummary?.backdrops?[safe: 1]?.filePath?.getPhotoUrl(isThumb: false) else { return false }
            
            // 抓過就不再抓了
            if self.imageUrlString == path { return false }
            
            self.imageUrlString = path
            return true
        }
        
        return false
    }
    
}
