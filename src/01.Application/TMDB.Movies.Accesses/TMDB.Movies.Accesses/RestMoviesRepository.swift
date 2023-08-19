//
//  RestMoviesRepository.swift
//  TMDB.Movies.Accesses
//
//  Created by Irving Huang on 2023/8/13.
//

import Foundation

import Infrastructure_Core
import Infrastructure_HttpClient

import TMDB_Movies_Core

public class RestMoviesRepository: MoviesRepository {
    
    
    //MARK: - Fields
    private var httpClient: HttpClient?
    private let endpoint = "movie/"
    
    
    //MARK: - Constructors
    public init(_ httpClient: HttpClient?) {
        self.httpClient = httpClient
    }
    
    
    //MARK: - Method
    public func findPlayingList(by page: Int) throws -> NowPlaying? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        let url = service + endpoint + "now_playing?language=en-US&page=\(page)"
        
        // respone
        let response = try getResponse(httpClient, url: url)
        let result = try NowPlaying(data: response.content)
        
        return result
    }
    
    
    public func findMovieDetail(by id: String) throws -> Movie? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        let url = service + endpoint + "\(id)?language=en-US"
        
        // respone
        let response = try getResponse(httpClient, url: url)
        let result = try Movie(data: response.content)
        
        return result
    }
    
    
}
