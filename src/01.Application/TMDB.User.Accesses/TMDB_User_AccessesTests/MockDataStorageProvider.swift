//
//  MockDataStorageProvider.swift
//  TMDB_User_AccessesTests
//
//  Created by Irving Huang on 2023/8/26.
//

import Infrastructure_DataStorage
import Infrastructure_HttpClient

public class MockDataStorageProvider: DataStorageProvider {
    
    // Properties to store mock data
    public var storedData: [String: BasicDataStorage] = [:]
    
    public init() { }
    
    public func set(_ data: BasicDataStorage) throws {
        storedData[data.key] = data
    }
    
    public func set(_ datas: [BasicDataStorage]) throws {
        for data in datas {
            storedData[data.key] = data
        }
    }
    
    public func delete(by key: String) throws {
        storedData.removeValue(forKey: key)
    }
    
    public func delete(by keys: [String]) throws {
        for key in keys {
            storedData.removeValue(forKey: key)
        }
    }
    
    public func fetchAll(by type: String) throws -> [Data] {
        return storedData.values.filter { $0.format == type }.map { $0.data }
    }
    
    public func fetch(by key: String, isValid: Bool = true) throws -> Data {
        guard let dataStorage = storedData[key] else {
            throw NSError(domain: "Data not found for key \(key)", code: 404, userInfo: nil)
        }
        
        if isValid && dataStorage.validDate < Date() {
            throw NSError(domain: "Data is expired for key \(key)", code: 410, userInfo: nil)
        }
        
        return dataStorage.data
    }
    
    public func fetch(by keys: [String], isValid: Bool = true) throws -> [Data] {
        var result: [Data] = []
        for key in keys {
            let data = try fetch(by: key, isValid: isValid)
            result.append(data)
        }
        return result
    }
}
