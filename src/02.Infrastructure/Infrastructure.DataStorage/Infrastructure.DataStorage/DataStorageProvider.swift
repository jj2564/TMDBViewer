//
//  DataStorageProvider.swift
//  Infrastructure.DataStorage
//
//  Created by Irving Huang on 2022/6/22.
//

import Foundation

public protocol DataStorageProvider {
    
    func set(_ data: BasicDataStorage) throws
    
    func set(_ datas: [BasicDataStorage]) throws
    
    func delete(by key: String) throws
    
    func delete(by keys: [String]) throws
    
    func fetchAll(by type: String) throws -> [Data]
    
    func fetch(by key: String, isValid: Bool) throws -> Data
    
    func fetch(by keys: [String], isValid: Bool) throws -> [Data]
}
