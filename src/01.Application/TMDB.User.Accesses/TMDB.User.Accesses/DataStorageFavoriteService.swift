//
//  DataStorageFavoriteService.swift
//  TMDB.User.Accesses
//
//  Created by Irving Huang on 2023/8/20.
//

import Foundation

import Infrastructure_HttpClient
import Infrastructure_DataStorage

import TMDB_User_Core

public class DataStorageFavoriteService: FavoriteService {
    
    
    
    //MARK: - Fields
    private var dataStorage: DataStorage?
    
    
    //MARK: - Constructors
    public init(_ dataStorage: DataStorage?) {
        self.dataStorage = dataStorage
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    public func add(by id: String, data: Data?) throws {
        
        // create
        let date = Date()
        let favorite = Favorite(id: id, createDate: date, data: data)
        let data = try jsonData(encodable: favorite)
        let object = BasicDataStorage(key: id, data: data, format: "Movie", validDate: .distantFuture)
        
        // save
        try dataStorage?.set(object)
    }
    
    public func delete(by id: String) throws {
        try dataStorage?.delete(by: id)
    }
    
    public func get(by id: String) throws -> Favorite? {
        guard let data = try dataStorage?.fetch(by: id, isValid: true) else { return nil }
        let result = try Favorite(data: data)
        
        return result
    }
    
    public func getIdList() throws -> [Favorite]? {
        
        guard let datas = try dataStorage?.fetchAll(by: "Movie") else { return nil }
        let result = datas.compactMap { try? Favorite(data: $0) }
        
        return result
    }
    
    
}
