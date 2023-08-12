//
//  DataStorage.swift
//  Infrastructure.DataStorage
//
//  Created by Irving Huang on 2022/6/22.
//

import Foundation

public class DataStorage {
    
    
    //MARK: - Constructors
    public required init(dataStorageProvider: DataStorageProvider) {
        self.dataStorageProvider = dataStorageProvider
    }
    
    
    //MARK: - Properties
    public private(set) var dataStorageProvider: DataStorageProvider!
    
    
    //MARK: - Methods
    public func set(_ data: BasicDataStorage) throws {
        try dataStorageProvider.set(data)
    }
    
    public func set(_ datas: [BasicDataStorage]) throws {
        try dataStorageProvider.set(datas)
    }
    
    public func fetch(by key: String, isValid: Bool = true) throws -> Data {
        try dataStorageProvider.fetch(by: key, isValid: isValid)
    }
    
    public func fetch(by keys: [String], isValid: Bool = true) throws -> [Data] {
        try dataStorageProvider.fetch(by: keys, isValid: isValid)
    }
    
    public func getValidDate() -> Date {

        let calendar = Calendar.current
        
        var date = Date()
        if let newDate = calendar.date(byAdding: .day, value: 1, to: date) {
            date = newDate
        }
        let components = calendar.dateComponents([
            .year, .month, .day], from: date)
        
        return calendar.date(from: components) ?? date
    }
    
}
