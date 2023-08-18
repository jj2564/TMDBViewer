//
//  MovieCardViewModel.swift
//  Application
//
//  Created by Irving Huang on 2023/8/16.
//

import Foundation

import TMDB_Movies_Core

class MovieCardViewModel: BaseViewModel {
    
    
    //MARK: - Fields
    
    
    //MARK: - Constructors
    required init() {
        super.init()
    }
    
    
    //MARK: - Properties
    public var movie: Movie? = nil {
        didSet { updateValue() }
    }
    
    public var imageUrl: String? = nil
    public var name: String? = nil
    public var date: Date? = nil
    public var summary: String? = nil
    
    
    //MARK: - Methods
    private func updateValue() {
        imageUrl = movie?.landscpaeThumbnailUrl
        name = movie?.originalTitle
        date = movie?.releaseDate
        summary = movie?.overview
    }
    
}
