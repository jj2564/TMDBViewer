//
//  RestPhotoRepository.swift
//  TMDB.Movies.Accesses
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

import Infrastructure_Core
import Infrastructure_HttpClient

import TMDB_Movies_Core

public class RestPhotoRepository: PhotosRepository {
    
    
    //MARK: - Fields
    private var httpClient: HttpClient?
    private let endpoint = "movie/"
    private let language = "language=en-US"
    
    
    //MARK: - Constructors
    public init(_ httpClient: HttpClient?) {
        self.httpClient = httpClient
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    public func findSummary(by movieId: Int) throws -> PhotoSummary? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        let url = service + endpoint + "\(movieId)" + "/images"
        
        // respone
        let response = try getResponse(httpClient, url: url)
        let result = try PhotoSummary(data: response.content)
        
        return result
    }
    
    
}
