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
    private let language = "language=en-US"
    
    
    //MARK: - Constructors
    public init(_ httpClient: HttpClient?) {
        self.httpClient = httpClient
    }
    
    
    //MARK: - Method
    public func findPlayingList(by page: Int) throws -> MovieListSummary? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        guard let session = httpClient?.sessionString else { throw "Session Error" }
        let url = service + endpoint + "now_playing?page=\(page)&" + language + "&\(session)"
        
        // respone
        let response = try getResponse(httpClient, url: url)
        let result = try MovieListSummary(data: response.content)
        
        return result
    }
    
    
    public func findMovieDetail(by id: String) throws -> Movie? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        guard let session = httpClient?.sessionString else { throw "Session Error" }
        let url = service + endpoint + "\(id)?" + language + "&\(session)"
        
        // respone
        let response = try getResponse(httpClient, url: url)
        let result = try Movie(data: response.content)
        
        return result
    }
    
    public func find(by query: String) throws -> MovieListSummary? {
        
        // create url
        guard let service = httpClient?.serviceUrl else { throw "URL Error" }
        guard let session = httpClient?.sessionString else { throw "Session Error" }
        let url = service + "search/movie?" + language + "&" + "query=\(query)" + "&\(session)"
        
        // response
        let response = try getResponse(httpClient, url: url)
        let result = try MovieListSummary(data: response.content)
        
        return result
    }
    
    
}
